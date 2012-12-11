class AddCurrentQuestionIndexToGame < ActiveRecord::Migration
  def change
    add_column :games, :current_question_index, :integer
  end
end
