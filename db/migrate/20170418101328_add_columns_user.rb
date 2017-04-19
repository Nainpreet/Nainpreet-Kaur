class AddColumnsUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :verification_code, :string
    add_column :users, :is_verified, :boolean
    change_column :users, :phone, :string 
  end
end
