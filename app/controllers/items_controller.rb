class ItemsController < ApplicationController

  before_action :set_item, only: [:show]
  before_action :authenticate_user!, only: [:index, :new]
  before_action :check_admin_user, only: [:index, :new]

  def index 
    @items = Item.all
  end

  def new 
    @item = Item.new
    @product_categories = ProductCategory.all
  end

  def create 
    @item = Item.new(set_params) 
    @product_categories = ProductCategory.all

    if @item.save 
      redirect_to @item, notice: 'Produto cadastrado com sucesso'
    else 
      flash.now[:alert] = 'Houve um problema para cadastrar o produto'
      render :new  
    end
  end

  def show
    # id = @item.id
    @product_category = ProductCategory.find(params[:id]).name
  end

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
                                :code,
                                :product_category_id)
  end

  def check_admin_user 
    unless current_user.admin?
      redirect_to root_path, alert: "Você não tem permissão para acessar esta página"
    end
  end
end