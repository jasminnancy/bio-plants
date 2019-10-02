class CreatePlants < ActiveRecord::Migration[6.0]
  def change
    create_table :plants do |t|
      t.string :name
      t.string :nickname
      t.integer :health, default: 80
      t.integer :happiness, default: 60
      t.integer :hunger, default: 80
      t.integer :resilience
      t.integer :user_id

      t.timestamps
    end
  end
end
