class FavouritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favourites = User.find(current_user.id).favourites.map{
        |f| f.product
    }
  end

  def create
    @favourite = Favourite.new(user_id: favourite_params[:user_id],
                               product_id: favourite_params[:product_id]).save!
    UserActivity.new(
        user_id: current_user.id,
        object_id: favourite_params[:product_id],
        action: UserActivity.actions[:product_favorite],
        time_performed: Time.now.utc
    ).save!
    redirect_to "/items/#{favourite_params[:product_id]}"
  end

  def show
    redirect_to "/items/#{params[:product_id]}"
  end

  def destroy
    f = Favourite.where(user_id: favourite_params[:user_id],
                        product_id: favourite_params[:product_id])
    if f.present?
      f.destroy_all
      render json: { success: true }, status: :ok
    else
      render json: {error: 'Could not find favourite'},
             status: :not_found
    end
  end

  private

  def favourite_params
    params.permit(:user_id, :product_id)
  end
end
