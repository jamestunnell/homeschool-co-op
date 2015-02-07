class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.text :description
      t.boolean :workshop
      t.references :subject, index: true
      t.timestamps null: false
    end
    add_index :courses, :name, unique: true
    add_foreign_key :courses, :subjects
  end
end
