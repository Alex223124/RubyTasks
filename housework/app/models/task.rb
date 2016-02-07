class Task < ActiveRecord::Base
  has_many :marks

  validates :title, presence: true
end
