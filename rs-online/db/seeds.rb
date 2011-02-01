# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

# default priorities
Priority.create :level => "none"
Priority.create :level => "low"
Priority.create :level => "normal"
Priority.create :level => "high"
Priority.create :level => "very high"

# default statuses
Status.create :status => "downloaded"
Status.create :status => "offline"
Status.create :status => "online"
Status.create :status => "downloading"
Status.create :status => "waiting"
Status.create :status => "interrupted"