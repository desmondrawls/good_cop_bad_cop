class Cop < ActiveRecord::Base
  belongs_to :precinct
  has_many :comments
  has_many :ratings

  # accepts_nested_attributes_for :precinct

  validates :name, presence: true
  validates :badge_number, presence: true,
    numericality: true,
    uniqueness: true

  def self.best
    Cop.all.select{|cop| cop.approval_rating.is_a?(Numeric)}.sort{ |x,y| x.approval_rating <=> y.approval_rating}.last
  end

  def self.worst
    Cop.all.select{|cop| cop.approval_rating.is_a?(Numeric)}.sort{ |x,y| x.approval_rating <=> y.approval_rating}.first
  end

  # def self.sort_by_approval
  #   Cop.all.select{|cop| cop.approval_rating.is_a?(Numeric)}.sort{ |x,y| x.approval_rating <=> y.approval_rating}.first
  # end

  def self.find_by_badge_or_name(search_params)
    send("search_by_" + search_params.keys[0], search_params.values[0])
  end

  def self.search_by_badge_number(badge)
    where(:badge_number => badge)
  end

  def self.search_by_name(name)
    where("name like ?", "%#{name}%")
  end

  def precinct_number
    precinct.number if precinct
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

  def precinct_attributes=(attributes)
    self.precinct = Precinct.where(attributes).first_or_create
  end

  def cpr_rating
    ratings.rounded_averages
  end
end
