class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true

  validates :text, presence: true
end
