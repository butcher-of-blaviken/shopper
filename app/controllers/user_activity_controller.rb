class UserActivityController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_activities = UserActivity.where(user_id: current_user.id)
    @activities_by_action = ActiveRecord::Base.connection.execute(
        'select object_id, action, count(object_id) from user_activities where user_id = 1 group by object_id, action'
    ).map{ |row| row.symbolize_keys }
  end
end
