class CreateStatuses < ActiveRecord::Migration
	def self.up
		create_table :statuses do |t|
			t.column :status, :string, :null => false, :unique => true
			t.timestamps
		end
	end

	def self.down
		drop_table :statuses
	end
end
