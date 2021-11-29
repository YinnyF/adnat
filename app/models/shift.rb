class Shift < ApplicationRecord
  belongs_to :user

  def employee_name
    self.user.name
  end

  def date
    date = parse_start
    date.strftime("%d/%m/%Y")
  end

  def start_time
    start = parse_start
    start.strftime("%I:%M %p")
  end

  def finish_time
    finish = parse_finish
    finish.strftime("%I:%M %p")
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

    def minutes_worked
      (finish-start)/60
    end

    def hours_worked_unrounded
      # break is defined in minutes
      (minutes_worked-break_length.to_i)/60
    end
end
