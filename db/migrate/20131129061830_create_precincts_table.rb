class CreatePrecinctsTable < ActiveRecord::Migration
  def change
    create_table :precincts do |t|
      t.integer :zip_code
    end
  end
end
