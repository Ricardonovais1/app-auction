class ProductCategoriesController < ApplicationController

  def new 
    @product_category = ProductCategory.new
    @product_categories = ProductCategory.all
  end

  def create
    @product_categories = ProductCategory.all 
    @product_category = ProductCategory.new(params.require(:product_category).permit(:name))

    if @product_category.save
      redirect_to root_path, notice: 'Nova categoria de produto salva com sucesso'
    else
      flash.now[:alert] = 'Houve um problema'
      render :new 
    end
  end
end