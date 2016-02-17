class Task < ActiveRecord::Base
  has_many :marks

  belongs_to :user

  belongs_to :category

  validates :title, presence: true
end
