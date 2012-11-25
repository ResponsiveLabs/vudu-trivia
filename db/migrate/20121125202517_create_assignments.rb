class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :game_id
      t.integer :question_id
    end
    add_index :assignments, :game_id
    add_index :assignments, :question_id
  end
end
