class PagesController < ApplicationController
  # TO DO - this functionality was started but never completed.
  def search
    query = params[:search]
    if query.present?
      @products = Product.where('LOWER(name) LIKE ?', "%#{search.downcase}%") if search.present?
    else
      @products = Product.all
    end
  end
end
