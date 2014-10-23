class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :cop, index: true
      t.integer :courtesy
      t.integer :professionalism
      t.integer :respect

      t.timestamps
    end
  end
end
