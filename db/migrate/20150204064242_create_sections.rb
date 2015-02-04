class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.decimal :fee
      t.references :session, index: true
      t.references :room, index: true
      t.references :adult, index: true
      t.references :course, index: true

      t.timestamps null: false
    end
    add_foreign_key :sections, :sessions
    add_foreign_key :sections, :rooms
    add_foreign_key :sections, :adults
    add_foreign_key :sections, :courses
  end
end
