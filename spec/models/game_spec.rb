require 'spec_helper'

describe "Game" do
  before(:all) do
    # Create our current user
    @user = User.new
    @user.id = 1001
    # Create 10 dummy questions
    10.times { |i| create(:question) }
  end

  before do
    Attempt.delete_all
  end

  it "selects new questions for the user" do
    # Simulate some attempted questions
    q2_id, q4_id = Question.all[2].id, Question.all[4].id
    Attempt.create(user_id: @user.id, question_id: q2_id)
    Attempt.create(user_id: @user.id, question_id: q4_id)
    # Remaining of this set operation reflects the elements of the first set that are not in the second
    # E.g. [1,2] - [3,4,5] => [1,2], [1,2] - [1,2,3] => []
    ids_not_to_be_included = [q2_id, q4_id]
    ids_selected = Game.select_questions_for_user(4, @user).map { |q| q.id }
    set_diff = ids_not_to_be_included - ids_selected
    # This means that selected questions does not include already attempted questions
    set_diff.should == ids_not_to_be_included
  end

  it "fills with attempted questions when remaining unwatched questions are not enough" do
    # Watch 9 questions
    ids_not_to_be_included = []
    9.times.each do |n|
      a_question_id = Question.all[n].id
      ids_not_to_be_included << a_question_id
      Attempt.create(user_id: @user.id, question_id: a_question_id)
    end
    ids_not_to_be_included.size.should == 9

    # Get questions
    ids_selected = Game.select_questions_for_user(4, @user).map { |q| q.id }
    set_diff = ids_not_to_be_included - ids_selected

    # Still returns the amount of questions requested
    ids_selected.size.should == 4
    # At least 3 already seen questions where collected
    set_diff.size.should == ids_not_to_be_included.size - 3
    # IDs used to fill were the oldest
    oldest_attempts = Question.all[0..2].map { |q| q.id }
    ids_selected.should == ( [Question.all[9].id] + oldest_attempts )
  end

  it "restarts the attempts history of a user after watching all questions" do
    # User has watched all available questions
    Question.all.size.times.each do |n|
      Attempt.create(user_id: @user.id, question_id: Question.all[n].id)
    end

    ids_selected = Game.select_questions_for_user(4, @user).map { |q| q.id }
    Attempt.where(user_id: @user.id).size.should == 0
  end

  it "returns all questions when attempts are empty" do
    questions = Game.select_questions_for_user(4, @user)
    questions.size.should == 4
  end

end
