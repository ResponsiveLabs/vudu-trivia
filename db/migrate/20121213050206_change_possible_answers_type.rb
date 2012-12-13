class ChangePossibleAnswersType < ActiveRecord::Migration
  def up
    change_column :questions, :possible_answers, :string, null: false
  end

  def down
    change_column :questions, :possible_answers, :text
  end
end
