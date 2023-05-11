class LotItemsController < ApplicationController 
  def new
    @lot = Lot.find(params[:lot_id])
    @lot_item = LotItem.new
    @items = Item.all
  end

  def create 
    @lot = Lot.find(params[:lot_id])

    @lot.lot_items.create(set_params)
    redirect_to @lot, notice: "Item adicionado com sucesso"
  end

  private 

  def set_params 
    params.require(:lot_item).permit(:item_id)
  end
end