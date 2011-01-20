class CreateStatuses < ActiveRecord::Migration
	def self.up
		create_table :statuses do |t|
			t.column :status, :string, :null => false, :unique => true
			t.timestamps
		end

		# default statuses
		Status.create :status => "downloaded"
		Status.create :status => "offline"
		Status.create :status => "online"
		Status.create :status => "downloading"
		Status.create :status => "waiting"
		Status.create :status => "interrupted"
	end

	def self.down
		drop_table :statuses
	end
end
