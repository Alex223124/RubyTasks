class Mark < ActiveRecord::Base
  belongs_to :task

  belongs_to :user

  validates :number, :task_id, :user_id, presence: true
end
