class ChangeColumnFromIntegerToDecimal < ActiveRecord::Migration[5.1]
  def change
  	change_column :users, :bring_forward, :decimal, :precision => 10, :scale => 1, null: false 
  	change_column :users, :replacement_leave, :decimal, :precision => 10, :scale => 1, null: false 
  end
end
