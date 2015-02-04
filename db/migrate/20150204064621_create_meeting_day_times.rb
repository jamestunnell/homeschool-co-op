class CreateMeetingDayTimes < ActiveRecord::Migration
  def change
    create_table :meeting_day_times do |t|
      t.integer :day
      t.time :start_time
      t.time :end_time
      t.references :section, index: true

      t.timestamps null: false
    end
    add_foreign_key :meeting_time_days, :sections
  end
end
