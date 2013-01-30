require 'spec_helper'

describe "Game" do

  it "selects the correct amount of questions" do
    amount = 3
    Game.select_questions(amount).size.should == amount
  end

  it "selects new questions for the user" do
    new_question = create(:question)
    puts new_question.inspect
  end

end
