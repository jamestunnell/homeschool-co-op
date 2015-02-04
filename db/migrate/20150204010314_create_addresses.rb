class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city
      t.integer :state
      t.string :zip
      t.references :building
      
      t.timestamps null: false
    end
  end
end
