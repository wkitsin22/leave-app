class User < ApplicationRecord
  # Include default devise modules Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :email, presence: true, uniqueness: true, format: {
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  }

  validates :hod_email, presence: true

  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :leave_applications
  before_save :forward_to_zero
  before_save :replacement_to_zero
  before_save :calculate_leave

  def forward_to_zero
    self.bring_forward = 0 unless bring_forward != nil
  end

  def replacement_to_zero
   self.replacement_leave = 0 unless replacement_leave != nil
  end

  def calculate_leave
    tot_leave = total_al + bring_forward + replacement_leave
    balance = tot_leave - leave_taken
    if id == nil
      self.total_leave = tot_leave
      self.balace = balance
    else
      self.update_columns(total_leave: tot_leave, balace: balance)
    end
  end

  def add_on_replacement_leave(rep_leave_dates)
    rep = replacement_leave + rep_leave_dates.count(',') + 1
    self.replacement_leave = rep
  end
end
