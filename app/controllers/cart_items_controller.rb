class CartItemsController < ApplicationController
  def index
    @cart = current_cart
  end

  def create
    @cart = current_cart
    product = Product.find(params[:product_id])

    # Find existing cart item or create a new one
    @cart_item = @cart.cart_items.find_or_initialize_by(product: product)
    @cart_item.quantity += 1
    @cart_item.save

    respond_to do |format|
      format.html do
        redirect_to products_path, notice: "#{product.name} added to cart."
      end
      format.turbo_stream
    end
  end

  def update
    @cart = current_cart
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    @cart = current_cart
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy

    redirect_to cart_items_path(@cart_item.cart)
    # respond_to do |format|
    #   format.html {  }
    #   format.turbo_stream
    # end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end

  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end
end
