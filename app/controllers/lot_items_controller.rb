class LotItemsController < ApplicationController 
  before_action :check_admin_user,  only: [:new]
  before_action :set_lot,           only: [:new, :create, :remove]
  before_action :check_lot_creator, only: [:new]

  def new
    @lot_item = LotItem.new
    @items = Item.all
  end

  def create 
    if @lot.lot_items.create(set_params)
      redirect_to @lot, notice: "Item adicionado com sucesso"
    else 
      @items = Item.all
      flash.now[:alert] = 'Você não selecionou nenhum item' 
      render :new
    end
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
    params.require(:lot_item).permit(:item_id, :lot_id)
  end

  def check_admin_user
    unless user_signed_in? && current_user.admin?
      redirect_to root_path, alert: 'Você não tem permissão para acessar esta página'
    end
  end

  def check_lot_creator
    unless @lot.by_email == current_user.email
      redirect_to @lot, notice: 'Apenas o criador do lote pode adicionar ítens'
    end
  end
end