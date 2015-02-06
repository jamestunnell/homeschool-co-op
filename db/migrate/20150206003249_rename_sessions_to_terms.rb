class RenameSessionsToTerms < ActiveRecord::Migration
  def change
    rename_table :sessions, :terms
  end
end
