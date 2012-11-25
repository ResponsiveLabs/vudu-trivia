class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.text :explanation
      t.string :answer_url
      t.integer :points_to_earn
      t.integer :timer_in_seconds
      t.boolean :published
      t.datetime :started_at

      t.timestamps
    end
  end
end
