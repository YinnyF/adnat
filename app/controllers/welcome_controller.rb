class WelcomeController < ApplicationController
  def home
    @organisations = Organisation.all
    @organisation = Organisation.new
  end
end
