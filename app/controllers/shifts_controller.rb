class ShiftsController < ApplicationController
  before_action :set_shift, only: %i[show edit update destroy]
  # user must be logged in to do anything with shifts
  before_action :authenticate_user!
  before_action :redirect_if_no_org

  # GET /shifts or /shifts.json
  def index
    @shifts = Shift.order('start desc')
    @shift = Shift.new
  end

  # GET /shifts/1 or /shifts/1.json
  def show
  end

  # GET /shifts/new
  def new
    @shift = Shift.new
  end

  # GET /shifts/1/edit
  def edit
  end

  # POST /shifts or /shifts.json
  def create
    # TODO can we refactor this to the model?
    day_string = "%02i" % shift_params["date(1i)"]
    month_string = "%02i" % shift_params["date(2i)"]

    date_string = day_string + month_string + shift_params["date(3i)"]
    start_time_string = "#{shift_params["start(4i)"]}:#{shift_params["start(5i)"]}"
    finish_time_string = "#{shift_params["finish(4i)"]}:#{shift_params["finish(5i)"]}"
    required_dt_format = "%Y%m%dT%H:%M"

    start_dt = DateTime.strptime("#{date_string}T#{start_time_string}", required_dt_format)
    finish_dt = DateTime.strptime("#{date_string}T#{finish_time_string}", required_dt_format)

    finish_dt += 1.day if start_dt > finish_dt 

    @shift = Shift.new(start: start_dt, finish: finish_dt, break_length: shift_params[:break_length])
    @shift.user = current_user

    respond_to do |format|
      if @shift.save
        format.html { redirect_to shifts_path, notice: "Shift was successfully created." }
        format.json { render :show, status: :created, location: @shift }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shifts/1 or /shifts/1.json
  def update
    # TODO can we refactor this to the model?
    day_string = "%02i" % shift_params["date(1i)"]
    month_string = "%02i" % shift_params["date(2i)"]

    date_string = day_string + month_string + shift_params["date(3i)"]
    start_time_string = "#{shift_params["start(4i)"]}:#{shift_params["start(5i)"]}"
    finish_time_string = "#{shift_params["finish(4i)"]}:#{shift_params["finish(5i)"]}"
    required_dt_format = "%Y%m%dT%H:%M"

    start_dt = DateTime.strptime("#{date_string}T#{start_time_string}", required_dt_format)
    finish_dt = DateTime.strptime("#{date_string}T#{finish_time_string}", required_dt_format)

    finish_dt += 1.day if start_dt > finish_dt 

    respond_to do |format|
      if @shift.update(start: start_dt, finish: finish_dt, break_length: shift_params[:break_length])
        format.html { redirect_to @shift, notice: "Shift was successfully updated." }
        format.json { render :show, status: :ok, location: @shift }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shifts/1 or /shifts/1.json
  def destroy
    @shift.destroy
    respond_to do |format|
      format.html { redirect_to shifts_url, notice: "Shift was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shift
      @shift = Shift.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def shift_params
      params.require(:shift).permit(:date, :start, :finish, :break_length)
    end

    def redirect_if_no_org
      redirect_to root_path unless current_user.membership
    end
end
