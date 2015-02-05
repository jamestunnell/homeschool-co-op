class AddWorkshopToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :workshop, :boolean
  end
end
