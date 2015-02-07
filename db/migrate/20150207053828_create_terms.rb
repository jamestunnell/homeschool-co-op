class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.integer :season
      t.date :start_date
      t.date :end_date
      t.boolean :workshop
      t.timestamps null: false
    end
  end
end
