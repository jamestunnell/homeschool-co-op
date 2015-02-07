class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.decimal :fee
      t.references :term, index: true
      t.references :room, index: true
      t.references :user, index: true
      t.references :course, index: true
      t.timestamps null: false
    end
    add_foreign_key :sections, :terms
    add_foreign_key :sections, :rooms
    add_foreign_key :sections, :users
    add_foreign_key :sections, :courses
  end
end
