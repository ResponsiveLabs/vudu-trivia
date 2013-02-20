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

  describe "when finished" do
    before(:all) do
      @current_user = User.create(email: "foo@foo.bar", password: "foobar")

      # Destroy all badges and assignments
      Badge.keys.each { |b| Badge.find(b).delete }
      BadgesSash.destroy_all

      # Assign the only badge to the current user
      @some_badge = create(:badge)
      @current_user.add_badge(@some_badge.id)

      # Game over
      @finished_game = Game.new
      # Game was created 10 seconds before the badge assignment
      @finished_game.created_at = BadgesSash.last.created_at - 10
      @finished_game.user = @current_user
      @finished_game.save
    end

    it "should give the user a badge" do
      merits = BadgesSash.where(sash_id: @current_user.sash_id)
      merits.should_not be_empty
    end

    it "returns badges ids earned by the user" do
      @finished_game.badges_ids_earned_by_user.should == [@some_badge.id]
    end
  end

end
