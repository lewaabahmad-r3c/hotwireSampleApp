class ApplicationController < ActionController::Base
  before_action :current_cart

  private

  def current_cart
    if session[:cart_id]
      @current_cart ||= Cart.includes(:products).find_by(id: session[:cart_id])
      session.delete(:cart_id) if @current_cart.nil? # Handle cases where cart has been deleted
    end
    if session[:cart_id].nil?
      @current_cart = Cart.create
      session[:cart_id] = @current_cart.id
    end
    @current_cart
  end
end
