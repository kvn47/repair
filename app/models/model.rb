class Model < ActiveRecord::Base
  has_many :jobs
  attr_accessible :name
  validates :name, :presence => true
end
