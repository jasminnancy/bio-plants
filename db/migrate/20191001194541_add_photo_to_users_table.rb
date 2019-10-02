class AddPhotoToUsersTable < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :profile_pic, :string, :default => "https://i.pinimg.com/474x/d1/06/ec/d106ec67e8b5e1195ba7bfb60c9de72c.jpg"
  end
end
