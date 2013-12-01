class Cop < ActiveRecord::Base
  belongs_to :precinct
  has_many :comments

  def self.find_by_badge_or_name(badge, name)
    if badge && badge != ""
      Cop.where(:badge_number => badge)
    elsif name && name != ""
      Cop.where("name like ?", "%#{name}%")
    end
  end

  def precinct_name
    precinct.name
  end

  def approval_rating
    if self.approves != 0 || self.disapproves != 0
      self.approves.to_f / (self.approves.to_f + self.disapproves.to_f)
    else
      "n/a"
    end
  end

  def approval
    self.approves = self.approves + 1
  end

  def disapproval
    self.disapproves = self.disapproves + 1
  end

end
