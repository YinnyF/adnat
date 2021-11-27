class MembershipsController < ApplicationController
  def create
    # @organisation = Organisation.find(params[:organisation_id])
    # @membership = @organisation.memberships.create()
    # @membership.user = current_user
    

    redirect_to root_path
  end

  def destroy

  end

  # # private
  #   def membership_params
  #     params.require(:membership).permit()
  #   end

end
