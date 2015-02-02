class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.string :first
      t.string :last
      t.date :birth_date
      t.references :adult, index: true
            
      t.timestamps null: false
    end
  end
end
