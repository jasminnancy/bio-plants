class CreateCareActions < ActiveRecord::Migration[6.0]
  def change
    create_table :care_actions do |t|
      t.integer :plant_id
      t.integer :user_id
      t.integer :action_id
      
      t.timestamps
    end
  end
end
