class Estimation < ActiveRecord::Base
  belongs_to :task

  validates :task_id, :end_time, presence: true
  validates :task_id, uniqueness: true
end
