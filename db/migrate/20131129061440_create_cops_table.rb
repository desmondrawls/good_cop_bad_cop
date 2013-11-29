class CreateCopsTable < ActiveRecord::Migration
  def change
    create_table :cops do |t|
      t.string :name
      t.integer :badge_number
      t.integer :precinct_id
      t.integer :approval_rating
    end
  end
end
