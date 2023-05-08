class ItemsController < ApplicationController
  def index 
    @items = Item.all
  end

  def new 
    @item = Item.new
  end


  def create 
    @item = Item.new(set_params)   
    
    
  end

  private 

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