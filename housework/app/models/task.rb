class Task < ActiveRecord::Base
  include AASM

  has_one :mark
  belongs_to :user
  belongs_to :category
  has_one :estimation
  has_many :comments, as: :commentable

  validates :title, :user_id, presence: true

  aasm :column => 'status' do
    state :sleeping, :initial => true
    state :waiting
    state :suspending
    state :running
    state :finishing

    event :run do
      transitions :from => [:waiting, :suspending], :to => :running
    end

    event :suspend do
      transitions :from => :running, :to => :suspending
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
