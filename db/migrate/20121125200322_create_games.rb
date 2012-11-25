class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :earned_points
      t.integer :correct_answers_count

      t.timestamps
    end
  end
end
