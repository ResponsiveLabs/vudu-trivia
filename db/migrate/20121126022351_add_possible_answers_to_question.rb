class AddPossibleAnswersToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :possible_answers, :text
  end
end
