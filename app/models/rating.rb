class Rating < ActiveRecord::Base
  belongs_to :cop

  CATEGORIES = [:courtesy, :professionalism, :respect].freeze

  def self.rounded_averages
  	Hash[CATEGORIES.map{|column| [column, self.rounded_average(column)]}]
  end

  def self.rounded_average(column)
  	self.average(column).to_f.round(1)
  end

end

