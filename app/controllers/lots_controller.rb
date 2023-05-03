class LotsController < ApplicationController
  before_action :set_lot, only: [:show]

  def index 
    @lots = Lot.all
  end


  def show
  end

  private 

  def set_lot 
    @lot = Lot.find(params[:id])
  end
end