class CreateAttempts < ActiveRecord::Migration
  def up
    create_table :attempts do |t|
      t.integer :user_id
      t.integer :question_id
    end
    add_index :attempts, :user_id
    add_index :attempts, :question_id
  end

  def down
    drop_table :attempts
  end
end
