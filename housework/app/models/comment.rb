class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  has_many :comments, :as => :commentable
  belongs_to :user, foreign_key: "author_id"

  has_ancestry

  validates :text, presence: true
end
