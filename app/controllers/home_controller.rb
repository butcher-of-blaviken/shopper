class HomeController < ApplicationController
  def index
    c = Service::Lcbo::Client.new
    @products = c.search(search_params[:search],
                         20, search_params[:page])
    @query = search_params[:search]
    @next_page = params[:page].to_i + 1
    Product.bulk_add_if_necessary(@products)
    @products = Product.where(id: @products.map{ |p| p[:id] })
  end

  private
  def search_params
    params.permit(:search, :page)
  end
end
