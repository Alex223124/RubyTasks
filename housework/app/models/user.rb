require 'elasticsearch/model'

class User < ActiveRecord::Base
  rolify
  include Elasticsearch::Model

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :registerable, :confirmable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_many :tasks

  has_many :parent_relationships, :foreign_key => "parent_id", :class_name => "Relationship"
  has_many :children, :through => :parent_relationships

  has_many :child_relationships, :foreign_key => "child_id", :class_name => "Relationship"
  has_many :parents, :through => :child_relationships

  has_many :comments, as: :commentable
  accepts_nested_attributes_for :comments,
                                :allow_destroy => true,
                                :reject_if     => :all_blank

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
    end
  end

  def as_indexed_json(options={})
    self.as_json(
      only: [:id, :name],
      include: {
        tasks: { only: [:title, :description] }
      }
    )
  end

  def self.import
    User.includes(:tasks).find_in_batches do |users|
      User.__elasticsearch__.client.bulk({
        index: ::User.__elasticsearch__.index_name,
        type: ::User.__elasticsearch__.document_type,
        body: users.map do |user|
          {
              index: {
                  _id: user.id,
                  data: user.as_indexed_json
              }
          }
        end
      })
    end
  end

  after_commit '__elasticsearch__.index_document', on: :create
  after_commit '__elasticsearch__.update_document', on: :update
  after_commit :update_index_on_destroy, on: :destroy

  def update_index_on_destroy
    __elasticsearch__.client.delete(
      index: User.index_name,
      type: User.document_type,
      id: id
    )
  end

  def self.search_by_name(params)
    query = "name: *#{params[:query]}*"
    es = User.__elasticsearch__.search(
      query: {query_string: {query: query}},
      size: 20
    )
    es.records.to_a
  rescue => e
    return search_by_name_db(params)
  end
end

#User.__elasticsearch__.create_index! force: true
#User.import

