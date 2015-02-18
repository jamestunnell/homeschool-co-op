class AddContactInfoToUser < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string
    add_column :users, :emergency_name, :string
    add_column :users, :emergency_phone, :string
  end
end
