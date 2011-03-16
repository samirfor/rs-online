class CreatePackages < ActiveRecord::Migration
  def self.up
    create_table :packages do |t|
      t.column :description, :string, :null => false
      t.column :comment, :text
      t.column :completed, :boolean
      t.column :show, :boolean
      t.column :problem, :boolean
      t.column :date_created, :timestamp
      t.column :date_started, :timestamp
      t.column :date_finished, :timestamp
      t.column :pass_phrase, :string
      t.column :priority_id, :integer, :null => false
      t.column :url_source, :string
      t.column :use_ip, :boolean
      t.column :size, :decimal, :default => 0, :precision => 10, :scale => 2
      t.timestamps
    end
    #add_column :size, :decimal, :default => 0, :precision => 10, :scale => 2
  end

  def self.down
    drop_table :packages
  end
end
