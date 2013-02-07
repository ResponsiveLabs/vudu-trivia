class Game < ActiveRecord::Base
  attr_accessible :correct_answers_count, :earned_points, :current_question_index

  has_many :assignments
  has_many :questions, through: :assignments
  belongs_to :user

  serialize :answered_right, Array

  def answer_question(question, answer)
    success = false
    if question.answered_right? answer
      self.correct_answers_count += 1
      self.earned_points += question.points_to_earn
      self.user.add_points(question.points_to_earn)
      self.user.save
      self.answered_right << question.id
      success = true
    end
    success
  end

  def has_ended?
    current_question_index >= questions.size
  end

  def self.select_questions_for_user(amount, user)
    # Find questions already seen
    attempted_questions_ids = Attempt.where(user_id: user.id).map { |a| a.question_id }
    # Fix query bug
    attempted_questions_ids = [-31337] if attempted_questions_ids.empty?
    # Find new questions
    new_questions = Question.find(:all, :conditions => ["id NOT IN (?)", attempted_questions_ids])
    questions = new_questions.shuffle[0...amount]

    # If there's not enough unseen questions, fill the array with old questions. Then reset history.
    remaining = amount - questions.size
    if remaining > 0
      oldest_attempts = attempted_questions_ids[0...remaining]
      old_questions = Question.find(:all, :conditions => ["id IN (?)", oldest_attempts])
      questions = questions | old_questions
      Attempt.delete_all(user_id: user.id)
    end

    questions
  end

end
