class BidsController < ApplicationController 
  before_action :set_lot, only: [:new, :create]
  before_action :authenticate_user!

  def new 
    @bid = Bid.new
  end

  def create 
    @bid = Bid.new(set_params)
    
      if @bid.save
        redirect_to @lot, notice: "Lance realizado com sucesso."
      else
        flash.now[:alert] = 'Não foi possível realizar o lance.'
        redirect_to @lot      
      end
  end

  private 

  def set_lot
    @lot = Lot.find(params[:lot_id])
  end

  def set_params 
    params.require(:bid).permit(:value, :lot_id, :user_id)
  end
end