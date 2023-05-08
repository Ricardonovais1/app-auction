class ItemsController < ApplicationController

  before_action :set_item, only: [:show]

  def index 
    @items = Item.all
  end

  def new 
    @item = Item.new
  end

  def create 
    @item = Item.new(set_params) 
    
    if @item.save 
      redirect_to @item, notice: 'Produto cadastrado com sucesso'
    else 
      flash.now[:alert] = 'Houve um problema para cadastrar o produto'
      render :new  
    end
  end

  def show; end

  private 

  def set_item
    @item = Item.find(params[:id])
  end

  def set_params 
    params.require(:item).permit(:name, 
                                :description,
                                :weight,
                                :height,
                                :depth,
                                :width,
                                :code)
  end
end