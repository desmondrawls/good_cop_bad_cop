class AddNameToPrecincts < ActiveRecord::Migration
  def change
    add_column :precincts, :name, :string
  end
end
