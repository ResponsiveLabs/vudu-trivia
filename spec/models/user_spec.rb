require 'spec_helper'

describe "User" do
  before do
    @user = User.new
    @questions = []
    [0, 1, 2, 3, 4].each do |id|
      q = Question.new
      q.id = id
      @questions << q
    end

    @game1 = Game.new
    @game1.questions = [ @questions[1], @questions[2] ]

    @game2 = Game.new
    @game2.questions = [ @questions[2], @questions[4] ]

    @user.games = [@game1, @game2]
  end

  it "gets ids of watched questions without duplicates" do
    @user.watched_questions_ids.should == [1, 2, 4]
  end

end

