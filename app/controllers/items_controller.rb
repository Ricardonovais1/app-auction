class ItemsController < ApplicationController

  before_action :set_item, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:new, :search]
  before_action :check_admin_user, only: [:new]

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
      render 'new' 
    end
  end

  def edit 
    @product_categories = ProductCategory.all
  end

  def update 
    if @item.update(set_params)
      redirect_to @item, notice: "Produto atualizado com sucesso"
    else  
      flash.now[:notice] = 'Não foi possível atualizar o produto'
      render 'edit'
    end
  end

  def show
    @product_category = ProductCategory.find(params[:id]).name
  end

  def search
    @query = params[:query]
    @items_code = Item.where('code LIKE ?', "%#{@query}%")
              .or(Item.where('name LIKE :query', query: "%#{@query}%"))
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
                                :product_category_id,
                                :image)
  end

  def check_admin_user 
    unless current_user.admin?
      redirect_to root_path, alert: "Você não tem permissão para acessar esta página"
    end
  end
end