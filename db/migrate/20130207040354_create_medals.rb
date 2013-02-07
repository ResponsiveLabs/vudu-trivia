class CreateMedals < ActiveRecord::Migration
  def up
    create_table :medals do |t|
      t.string :title
    end
  end

  def down
    drop_table :medals
  end
end
