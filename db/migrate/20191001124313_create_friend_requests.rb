class CreateFriendRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :friend_requests do |t|
      t.integer :user_id
      t.integer :friend_id
      
      t.timestamps
    end
  end
end
