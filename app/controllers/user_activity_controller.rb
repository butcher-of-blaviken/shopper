class UserActivityController < ApplicationController
  before_action :authenticate_user!

  def index
    #debugger
    @user_activities = UserActivity.where(user_id: current_user.id)
  end
end
