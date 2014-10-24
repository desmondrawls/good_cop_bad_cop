class Comment < ActiveRecord::Base
  belongs_to :cop

  validates :title, :presence => true
  validates :text, :presence => true
  validates :author, :presence => true
end