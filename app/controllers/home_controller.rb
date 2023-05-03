class HomeController < ApplicationController
  def index 
    @lots = Lot.all
  end
end