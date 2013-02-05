require 'spec_helper'

describe GamesController do

  describe "GET #finish" do
    it "works! (now write some real specs)" do
      @questions = []
      5.times.each do |id|
        q = create(:question)
        q.tag_list = "Terror, Comedia"
        q.save
        @questions << q
      end
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      @leet_user = User.new
      @leet_user.id = 31337
      @game_of_terror = Game.new
      @game_of_terror.id = 40000
      @game_of_terror.answered_right = @questions.collect(&:id).flatten
      @leet_user.games << @game_of_terror
      get :finish, id: @game_of_terror.id
    end
  end

end
