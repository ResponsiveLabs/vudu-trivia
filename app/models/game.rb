class Game < ActiveRecord::Base
  attr_accessible :correct_answers_count, :earned_points, :current_question_index

  has_many :assignments
  has_many :questions, through: :assignments

  def answer_question(question, answer)
    success = false
    if question.answered_right? answer
      self.correct_answers_count += 1
      self.earned_points += question.points_to_earn
      success = true
    end
    self.current_question_index += 1
    success
  end

end
