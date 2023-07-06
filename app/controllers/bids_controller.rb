# frozen_string_literal: true

class BidsController < ApplicationController
  before_action :set_lot, only: %i[new create]
  before_action :authenticate_user!

  def new
    @bid = Bid.new
  end

  def create
    @bid = Bid.new(set_params)
    @bid.user = current_user
    @bid.lot = @lot

    if @bid.save
      redirect_to @lot, notice: 'Lance realizado com sucesso.'
    else
      flash.now[:alert] = 'Não foi possível realizar o lance.'
      render 'new'
    end
  end

  private

  def set_lot
    @lot = Lot.find(params[:lot_id])
  end

  def set_params
    params.require(:bid).permit(:value)
  end
end
