class RemoveSeasonFromTerm < ActiveRecord::Migration
  def change
    remove_column :terms, :season
  end
end
