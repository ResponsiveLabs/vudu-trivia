class Game < ActiveRecord::Base
  attr_accessible :correct_answers_count, :earned_points

  has_many :assignments
  has_many :questions, through: :assignments
end
