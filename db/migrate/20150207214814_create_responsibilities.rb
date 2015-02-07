class CreateResponsibilities < ActiveRecord::Migration
  def change
    create_table :responsibilities do |t|
      t.integer :kind
      t.date :start_date
      t.date :end_date
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :responsibilities, :users
  end
end
