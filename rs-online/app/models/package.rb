class Package < ActiveRecord::Base

  attr_accessor :s_links
  # validate
  validates_presence_of :description
  validates_uniqueness_of :description

  # relationships
  belongs_to :priority
  has_many :links
end
