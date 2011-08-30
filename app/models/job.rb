class Job < ActiveRecord::Base
  belongs_to :model
  belongs_to :master, :class_name => 'User', :foreign_key => 'master_id'
  attr_accessor :model_name
  validates :model_id, :master_id, :serial, :presence => true
end
