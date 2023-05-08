class ProductCategoriesController < ApplicationController
  def new 
    @product_category = ProductCategory.new
  end

  def create 
    @product_category = ProductCategory.new(params.require(:product_category).permit(:name))

    @product_category.save
    redirect_to root_path, notice: 'Nova categoria de produto salva com sucesso'
  end
end