class ShiftCreator < ApplicationService
  def initialize(shift_params, user: nil)
    @shift_params = shift_params
    @user = user
  end

  def call
    create_shift
  end

  private

    def create_shift
      day_string = "%02i" % @shift_params["date(1i)"]
      month_string = "%02i" % @shift_params["date(2i)"]

      date_string = day_string + month_string + @shift_params["date(3i)"]
      start_time_string = "#{@shift_params["start(4i)"]}:#{@shift_params["start(5i)"]}"
      finish_time_string = "#{@shift_params["finish(4i)"]}:#{@shift_params["finish(5i)"]}"
      required_dt_format = "%Y%m%dT%H:%M"

      start_dt = DateTime.strptime("#{date_string}T#{start_time_string}", required_dt_format)
      finish_dt = DateTime.strptime("#{date_string}T#{finish_time_string}", required_dt_format)

      finish_dt += 1.day if start_dt > finish_dt 

      Shift.new(
        start: start_dt,
        finish: finish_dt,
        break_length: @shift_params[:break_length],
        user_id: @user.id
      )
    end
end