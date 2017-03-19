class WelcomeController < ApplicationController
  def index
    flash[:alert] = "good"
  end
end
