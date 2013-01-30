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
      self.user.points += question.points_to_earn
      self.user.save
      self.answered_right << question.id
      success = true
    end
    success
  end

  def has_ended?
    current_question_index >= questions.size
  end

  def self.select_questions(amount)
    # Question.find(:all, :conditions => ["id NOT IN (?)", user.watched_questions_ids]).limit(amount)
    Question.all.shuffle[0..amount-1]
  end

end
