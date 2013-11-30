class Cop < ActiveRecord::Base
  belongs_to :precinct

  def self.find_by_badge_or_name(badge, name)
    if badge && badge != ""
      Cop.where(:badge_number => badge)
    elsif name && name != ""
      Cop.where("name like ?", "%#{name}%")
    end
  end

end
