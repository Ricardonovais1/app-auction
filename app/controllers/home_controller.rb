class HomeController < ApplicationController
  def index 
    @lots = Lot.all
    @active_lots = Lot.active
    @future_lots = Lot.future
  end
end