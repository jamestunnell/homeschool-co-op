class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city
      t.integer :state
      t.string :zip
      t.integer :building_id, index: true
      
      t.timestamps null: false
    end
  end
end
