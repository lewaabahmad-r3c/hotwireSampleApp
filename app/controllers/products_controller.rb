class ProductsController < ApplicationController
  def index
    @cart = current_cart
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end
end
