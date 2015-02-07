class ReplaceEnrollableIdWithStudentId < ActiveRecord::Migration
  def change
    remove_index :enrollments, name: "index_enrollments_on_enrollable_type_and_enrollable_id"
    remove_column :enrollments, :enrollable_type, :string
    rename_column :enrollments, :enrollable_id, :student_id
    add_index :enrollments, :student_id
  end
end
