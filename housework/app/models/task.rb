class Task < ActiveRecord::Base
  has_many :marks

  belongs_to :user

  validates :title, presence: true
end
