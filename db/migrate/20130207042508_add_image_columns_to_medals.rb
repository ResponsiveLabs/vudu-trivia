class AddImageColumnsToMedals < ActiveRecord::Migration
  def self.up
    add_attachment :medals, :image
  end

  def self.down
    remove_attachment :medals, :image
  end
end
