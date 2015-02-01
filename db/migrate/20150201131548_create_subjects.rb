class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :name
      t.string :abbrev

      t.timestamps null: false
    end
    add_index :subjects, :name, unique: true
    add_index :subjects, :abbrev, unique: true
  end
end
