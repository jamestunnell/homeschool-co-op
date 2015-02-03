class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.integer :term
      t.integer :kind
      t.date :start_date
      t.date :end_date

      t.timestamps null: false
    end
  end
end
