class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.boolean :paid
      t.references :student, index: true
      t.references :section, index: true
      t.timestamps null: false
    end
    add_foreign_key :enrollments, :students
    add_foreign_key :enrollments, :sections
  end
end
