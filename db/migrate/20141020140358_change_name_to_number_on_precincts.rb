class ChangeNameToNumberOnPrecincts < ActiveRecord::Migration
  def change
  	remove_column :precincts, :name
  	add_column :precincts, :number, :integer
  end
end
