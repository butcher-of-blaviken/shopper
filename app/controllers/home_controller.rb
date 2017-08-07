class HomeController < ApplicationController
  def index
    c = Service::Lcbo::Client.new
    @products = Rails.cache.fetch(
        search_cache_key(search_params[:search], 20, search_params[:per_page]),
        expires_in: 1.hour) do
      c.search(search_params[:search],
               20, search_params[:page])
    end
    @query = search_params[:search]
    @next_page = params[:page].to_i + 1
    Product.bulk_add_if_necessary(@products)
    @products = Product.where(id: @products.map{ |p| p[:id] })
  end

  private
  def search_params
    params.permit(:search, :page)
  end

  def search_cache_key(query, per_page, page)
    "#{URI::encode(query||'')}-#{per_page.to_s}-#{page.to_s}"
  end
end
