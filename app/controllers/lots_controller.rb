class LotsController < ApplicationController
  before_action :set_lot, only: [:show]

  def index 
    @lots = Lot.all
  end

  def new 
    @lot = Lot.new
  end

  def create 
    @lot = Lot.new(set_params)
    @lot.by = current_user.name
    @lot.by_email = current_user.email
    if @lot.save
      redirect_to @lot, notice: "Lote cadastrado com sucesso" 
    else  
      flash.now[:notice] = 'Houve um erro ao cadastrar o lote'
      render :new
    end
  end

  def show
  end

  private 

  def set_lot 
    @lot = Lot.find(params[:id])
  end

  def set_params
    params.require(:lot).permit(:code, 
                                :start_date, 
                                :limit_date, 
                                :minimum_bid_value, 
                                :minimum_bid_difference, 
                                :by, 
                                :by_email)
  end
end