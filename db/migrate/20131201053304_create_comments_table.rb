class CreateCommentsTable < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :title
      t.string :text
      t.string :author
      t.integer :cop_id
    end
  end
end
