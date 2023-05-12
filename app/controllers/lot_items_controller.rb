class LotItemsController < ApplicationController 
  before_action :set_lot, only: [:new, :create, :remove]

  def new
    @lot_item = LotItem.new
    @items = Item.all
  end

  def create 
    @lot.lot_items.create(set_params)
    redirect_to @lot, notice: "Item adicionado com sucesso"
  end

  def remove
    @lot_item = @lot.lot_items.find(params[:id])
    @lot_item.destroy
    redirect_to @lot, notice: "Item removido com sucesso"
  end

  private 

  def set_lot
    @lot = Lot.find(params[:lot_id])
  end

  def set_params 
    params.require(:lot_item).permit(:item_id)
  end
end