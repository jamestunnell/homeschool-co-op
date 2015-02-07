class RenameChildToStudent < ActiveRecord::Migration
  def change
    rename_table :children, :students
  end
end
