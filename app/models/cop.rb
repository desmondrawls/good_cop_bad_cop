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
    if approves != 0 || disapproves != 0
      approves.to_f / (approves + disapproves)
    else
      "n/a"
    end
  end

  def approval
    self.approves += 1
  end

  def disapproval
    self.disapproves += 1
  end

end
