class WelcomeController < ApplicationController
  def index
    flash[:notice] = "厨留香"
  end 
end
