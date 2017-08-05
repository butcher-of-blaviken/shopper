class UserActivity < ApplicationRecord
  enum action: [:product_view, :product_favorite, :product_unfavorite]
  validates :user_id, presence: true
  validates :object_id, presence: true
  validates :action, presence: true
  validates :time_performed, presence: true
end
