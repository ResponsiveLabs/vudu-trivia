class AddImageToMedals < ActiveRecord::Migration
  def up
    add_column :medals, :image, :string
  end

  def down
    remove_column :medals, :image
  end
end
