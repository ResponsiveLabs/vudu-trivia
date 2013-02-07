require 'spec_helper'

describe "User" do
  before do
    Question.destroy_all
    @user = User.new
    @questions = []
    5.times.each do |id|
      q = create(:question)
      q.tag_list = "Terror, Comedia"
      q.save
      @questions << q
    end

    @game1 = Game.new
    @game1.questions = [ @questions[1], @questions[2] ]

    @game2 = Game.new
    @game2.questions = [ @questions[2], @questions[4] ]

    @user.games = [@game1, @game2]
  end

  it "gets ids of watched questions without duplicates" do
    @user.watched_questions_ids.should == [ @questions[1].id, @questions[2].id, @questions[4].id ]
  end

  describe "Badges" do
    before do
      @leet_user = User.new
      @leet_user.id = 31337
      @game_of_terror = Game.new
      @game_of_terror.answered_right = @questions.collect(&:id).flatten
      @leet_user.games << @game_of_terror
    end

    it "finds the number of questions answered correctly with a specific tag'" do
      @leet_user.number_of_questions_answered_right_and_tagged_as('Terror').should == 5
    end

  end

end

