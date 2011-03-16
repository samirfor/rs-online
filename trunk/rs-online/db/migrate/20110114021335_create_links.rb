class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.column :url, :string, :null => false
      t.column :filename, :string
      t.column :completed, :boolean
      t.column :size, :float
      t.column :date_started, :timestamp
      t.column :date_finished, :timestamp
      t.column :package_id, :integer, :null => false
      t.column :status_id, :integer, :null => false, :default => "5"
      t.column :tested, :boolean, :default => false
      t.timestamps
    end
    #add_column :status_id, :integer, :null => false, :default => "5"
  end

  def self.down
    drop_table :links
  end
end
