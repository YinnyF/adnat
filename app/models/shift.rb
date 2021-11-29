class Shift < ApplicationRecord
  belongs_to :user

  validates :start, :finish, presence: true
  validates :break_length, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 720 }

  validate :start_finish_check
  validate :break_length_check
  
  def employee_name
    self.user.name
  end

  def shift_date
    parse_start.strftime("%d/%m/%Y")
  end

  def start_time
    parse_start.strftime("%I:%M %p")
  end

  def finish_time
    parse_finish.strftime("%I:%M %p")
  end

  def hours_worked
    # display hrs to 2d.p.
    '%.2f' % hours_worked_unrounded
  end

  def cost
    # get the hourly rate for the user
    hourly_rate = self.user.membership.organisation.hourly_rate
    # hours worked * hourly rate
    # hourly rate is defined via user's org
    '%.2f' % (hours_worked_unrounded * hourly_rate)
  end

  private
    def parse_start
      DateTime.parse("#{self.start}")
    end

    def parse_finish
      DateTime.parse("#{self.finish}")
    end

    def shift_length_mins
      (finish-start)/60
    end

    def hours_worked_unrounded
      # break is defined in minutes
      (shift_length_mins-break_length.to_i)/60
    end

    def dates_valid
      begin
        self.start < self.finish
      rescue 
        false
      end
    end

    def start_finish_check
      errors.add(:finish, "Please select a time later than the start time") unless dates_valid
    end

    def break_valid
      begin
        self.break_length <= shift_length_mins
      rescue
        false
      end
    end

    def break_length_check
      errors.add(:finish, "Please check the break length") unless break_valid
    end
end
