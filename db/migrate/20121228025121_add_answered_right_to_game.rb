class AddAnsweredRightToGame < ActiveRecord::Migration
  def change
    add_column :games, :answered_right, :text
  end
end
