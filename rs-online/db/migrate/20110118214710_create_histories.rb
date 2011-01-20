class CreateHistories < ActiveRecord::Migration
  def self.up
    create_table :histories do |t|
      t.column :process, :integer
      t.column :message, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :histories
  end
end
