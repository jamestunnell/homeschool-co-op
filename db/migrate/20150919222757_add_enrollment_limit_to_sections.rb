class AddEnrollmentLimitToSections < ActiveRecord::Migration
  def change
    add_column :sections, :enrollment_limit, :integer
  end
end
