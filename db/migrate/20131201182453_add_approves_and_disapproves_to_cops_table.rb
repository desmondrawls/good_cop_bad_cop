class AddApprovesAndDisapprovesToCopsTable < ActiveRecord::Migration
  def change
    remove_column :cops, :approval_rating
    add_column :cops, :approves, :integer, default: 0
    add_column :cops, :disapproves, :integer, default: 0
  end
end

