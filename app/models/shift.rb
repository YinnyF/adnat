class Shift < ApplicationRecord
  belongs_to :user

  validates :start, :finish, presence: true
  validates :break_length, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 720 }

  validate :start_finish_check
  validate :break_length_check
  
  def employee_name
    user.name
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

  def sunday_premium_cost
    if start.sunday? && finish.sunday? 
      hours_worked_unrounded * hourly_rate
    elsif start.sunday?
      # if start on sunday and ends overnight
      calculate_sunday_start_premium
    elsif finish.sunday?
      # if start saturday working overnight into sunday
      calculate_sunday_end_premium
    else
      0
    end
  end

  def cost
    cost = sunday_premium_cost + (hours_worked_unrounded * hourly_rate)
    '%.2f' % cost
  end

  private
    def parse_start
      DateTime.parse("#{start}")
    end

    def parse_finish
      DateTime.parse("#{finish}")
    end

    def shift_length_mins
      (finish - start) / 60
    end

    def hours_worked_unrounded
      # break is defined in minutes
      (shift_length_mins - break_length.to_i) / 60
    end

    def hourly_rate
      user.membership.organisation.hourly_rate
    end

    def dates_valid
      begin
        start < finish
      rescue 
        false
      end
    end

    def start_finish_check
      errors.add(:finish, "Please select a time later than the start time") unless dates_valid
    end

    def break_valid
      begin
        break_length <= shift_length_mins
      rescue
        false
      end
    end

    def break_length_check
      errors.add(:finish, "Please check the break length") unless break_valid
    end

    def calculate_sunday_start_premium
      minutes_on_sunday = (start.midnight + 1.day - start) / 60

      if (shift_length_mins - minutes_on_sunday) < break_length
        # reduce minutes on sunday for the break_length
        minutes_on_sunday = shift_length_mins - break_length
      end

      hours_on_sunday = minutes_on_sunday / 60
      hours_on_sunday * hourly_rate
    end

    def calculate_sunday_end_premium
      minutes_on_sunday = (finish - finish.beginning_of_day) / 60

      if minutes_on_sunday > break_length
        hours_on_sunday = (minutes_on_sunday - break_length) / 60
        hours_on_sunday * hourly_rate
      else
        # if the break_length exceeds their mins worked on sunday then they get nothing
        0
      end
    end

end
