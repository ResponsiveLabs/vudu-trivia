class DefaultsForGame < ActiveRecord::Migration
  def up
    change_column_default :games, :correct_answers_count, 0
    change_column_default :games, :earned_points, 0
    change_column_default :games, :current_question_index, 0
  end
end
