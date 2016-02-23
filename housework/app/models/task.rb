class Task < ActiveRecord::Base
  include AASM

  has_one :mark
  belongs_to :user
  belongs_to :category
  has_one :estimation

  validates :title, :user_id, presence: true

  aasm :column => 'status' do
    state :sleeping, :initial => true
    state :waiting
    state :running
    state :finishing

    event :run do
      transitions :from => :waiting, :to => :running
    end

    event :finish do
      transitions :from => :running, :to => :finishing
    end

    event :sleep do
      transitions :from => [:running, :waiting], :to => :sleeping
    end

    event :wait do
      transitions :from => :sleeping, :to => :waiting
    end
  end

end
