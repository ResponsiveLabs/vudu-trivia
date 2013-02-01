class Attempt < ActiveRecord::Base
  attr_accessible :user_id, :question_id

  belongs_to :user
  belongs_to :question
end

