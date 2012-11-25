class Game < ActiveRecord::Base
  attr_accessible :correct_answers_count, :earned_points
end
