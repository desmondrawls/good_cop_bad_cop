class ChangeBadgeNumberFormatInCopsTable < ActiveRecord::Migration
  def change
  	change_column :cops, :badge_number, :string
  end
end
