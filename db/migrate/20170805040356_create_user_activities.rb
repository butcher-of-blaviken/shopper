class CreateUserActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :user_activities do |t|
      t.integer :user_id
      t.integer :object_id
      t.integer :action
      t.datetime :time_performed

      t.timestamps
    end

    add_index :user_activities, [:user_id, :object_id]
  end
end
