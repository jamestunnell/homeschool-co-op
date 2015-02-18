class AddMedicalToStudent < ActiveRecord::Migration
  def change
    add_column :students, :medical, :text
  end
end
