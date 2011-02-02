class CreateAbouts < ActiveRecord::Migration
  def self.up
    create_table :abouts do |t|
      t.string :name, :null => false
      t.text :bio
      t.string :email
      t.string :twitter
      t.string :website
      t.string :url_photo
      t.timestamps
    end
  end

  def self.down
    drop_table :abouts
  end
end
