class CreatePriorities < ActiveRecord::Migration
	def self.up
		create_table :priorities do |t|
			t.column :level, :string, :unique => true
			t.timestamps
		end

		# default priorities
		Priority.create :level => "none"
		Priority.create :level => "low"
		Priority.create :level => "normal"
		Priority.create :level => "high"
		Priority.create :level => "very high"
  end

  def self.down
    drop_table :priorities
  end
end
