class MembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_organisation
  
  def create
    # TODO: refactor here?
    @membership = Membership.new(user_id: current_user.id, organisation_id: @organisation.id)
    if @membership.save
        flash[:notice] = "Joined #{@organisation.name}"
    else
        # Set up multiple error message handler for rejections/already a member
        flash[:notice] = "Not able to join organisation."
    end

    redirect_to root_path
  end

  def destroy
    @membership = current_user.membership

    if @membership.destroy
      delete_all_shifts

      respond_to do |format|
        format.html { redirect_to root_path, notice: "Successfully left the organisation." }
        format.json { head :no_content }
      end
    end
  end

  private
    def set_organisation
      @organisation = Organisation.find(params[:organisation_id])
    end

    def delete_all_shifts
      Shift.where(user_id: current_user.id).delete_all
    end

end
