class StoreController < ApplicationController
  skip_before_action :authorize

  def main
    params[:is_cover] = true
    render 'main.html.erb'
  end

  include CurrentCart
  before_action :set_cart 
  def index
    if params[:set_locale]
      redirect_to store_url(locale: params[:set_locale])
    else
      @products = Product.order(:title)
    end
  end
end
