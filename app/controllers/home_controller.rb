class HomeController < ApplicationController
  def index 
    # @lot = Lot.find(params[:id])
    @lots = Lot.all
    @current_lots = Lot.approved
    @future_lots = Lot.future
  end
end