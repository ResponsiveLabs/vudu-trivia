class Question < ActiveRecord::Base
  attr_accessible :answer_url, :explanation, :points_to_earn, :published, :started_at, :timer_in_seconds, :title
end
