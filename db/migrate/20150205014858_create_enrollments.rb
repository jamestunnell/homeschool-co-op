class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.references :enrollable, index: true, polymorphic: true
      t.references :section, index: true

      t.timestamps null: false
    end
    add_foreign_key :enrollments, :enrollables
    add_foreign_key :enrollments, :sections
  end
end
