class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :first
      t.string :last
      t.date :birth_date
      t.references :user, index: true
      t.timestamps null: false
    end
    add_foreign_key :students, :users
  end
end
