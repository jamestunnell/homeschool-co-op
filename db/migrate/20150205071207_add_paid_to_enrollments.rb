class AddPaidToEnrollments < ActiveRecord::Migration
  def change
    add_column :enrollments, :paid, :boolean, default: false
  end
end
