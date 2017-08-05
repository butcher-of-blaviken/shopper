class ItemsController < ApplicationController

  ## Item detail view
  def show
    # Check if item in DB first before making a call
    @product = Product.find_by_id(item_params[:id])
    if @product.nil?
      # create the product by fetching from LCBO API and then displaying it
      c = Service::Lcbo::Client.new
      product_hash = c.product(item_params[:id])

      # If we visit the URL manually this could happen
      if product_hash.nil?
        render json: { error: 'Could not find product on LCBO' },
               status: :not_found
        return
      end

      # clean up the hash from all the extra data we don't need
      product_hash = Product.cleanup_product_hash(product_hash)
      @product = Product.new(product_hash)
      if !@product.save
        # something went wrong
        render json: { error: 'Could not process product'},
               status: :unprocessable_entity
        return
      end
    end
    if user_signed_in?
      # log view of product
      UserActivity.new(
                      user_id: current_user.id,
                      object_id: @product.id,
                      action: UserActivity.actions[:product_view],
                      time_performed: Time.now.utc
      ).save!
    end
  end

  private

  def item_params
    params.permit(:id)
  end
end
