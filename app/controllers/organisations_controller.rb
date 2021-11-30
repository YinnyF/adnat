class OrganisationsController < ApplicationController
  before_action :set_organisation, only: %i[ show edit update destroy ]

  # GET /organisations or /organisations.json
  def index
    @organisations = Organisation.all
  end

  # GET /organisations/1 or /organisations/1.json
  def show
  end

  # GET /organisations/new
  def new
    @organisation = Organisation.new
  end

  # GET /organisations/1/edit
  def edit
  end

  # POST /organisations or /organisations.json
  def create
    @organisation = Organisation.new(organisation_params)

    respond_to do |format|
      if @organisation.save
        join(@organisation)

        format.html { redirect_to root_path, notice: "Organisation was successfully created." }
        format.json { render :show, status: :created, location: @organisation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @organisation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organisations/1 or /organisations/1.json
  def update
    respond_to do |format|
      if @organisation.update(organisation_params)
        format.html { redirect_to root_path, notice: "Organisation was successfully updated." }
        format.json { render :show, status: :ok, location: @organisation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @organisation.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /organisations/1 or /organisations/1.json
  def destroy
    find_memberships_and_shifts_and_delete

    @organisation.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Organisation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organisation
      @organisation = Organisation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def organisation_params
      params.require(:organisation).permit(:name, :hourly_rate)
    end

    def join(organisation)
      @membership = Membership.new(user_id: current_user.id, organisation_id: organisation.id)
      
      # TODO: what if they already belong to an org?
      @membership.save
    end

    def find_memberships_and_shifts_and_delete
      Membership.where(organisation_id: @organisation.id).each do |membership| 
        Shift.where(user_id: membership.user_id).delete_all
        membership.destroy
      end
    end
end
