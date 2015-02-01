class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.string :first
      t.string :last
      t.date :birth_date

      t.timestamps null: false
    end
  end
end
