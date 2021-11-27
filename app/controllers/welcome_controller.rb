class WelcomeController < ApplicationController
  def home
    # not sure if this is the best place to put it
    @organisations = Organisation.all
    @organisation = Organisation.new
  end
end
