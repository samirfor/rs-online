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
      t.timestamps
    end
  end

  def self.down
    drop_table :links
  end
end
