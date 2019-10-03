class ChangeActionEffectColumn < ActiveRecord::Migration[6.0]
  def change
    change_column :actions, :effect, :string
  end
end
