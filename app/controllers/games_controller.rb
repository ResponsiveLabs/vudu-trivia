class GamesController < ApplicationController
  before_filter :load_facebook_user

  rescue_from ActiveRecord::RecordNotFound, :with => :not_found

  # POST /games
  # POST /games.json
  def create
    # TODO: should abort game creation if user is not logged in
    @game = Game.new(params[:game])

    @game.current_question_index = 0
    @game.questions = Game.select_questions(10)

    @user = User.find_user_with_facebook_graph(@me)
    unless @user.save
      format.html { render action: "welcome", notice: @user.errors }
      return false
    end

    @game.user = @user

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
      else
        format.html { render action: "welcome", notice: @game.errors }
      end
    end

  end

  # GET /games/1
  def show
    question
  end

  def question
    @game = Game.find(params[:id])
    render_question
  end

  def next
    @game = Game.find(params[:id])
    @game.current_question_index += 1
    @game.save
    render_question
  end

  def render_question
    @index = @game.current_question_index
    @question = @game.questions[@index]

    if @index < @game.questions.size
      render 'question'
    else
      redirect_to finish_url(@game), :status => :found
    end
  end

  def render_question_explanation
    @explain_answer = true
    render_question
  end

  # PUT /games/:id/questions/:question_id/answer
  def answer
    @game = Game.find(params[:id])
    @question = @game.questions[@game.current_question_index]
    @answered_right = @game.answer_question(@question, params[:answer])
    @game.save
    render_question_explanation
  end

  # GET /games/:id/finish
  def finish
    @game = Game.find(params[:id])
    @user = User.where(facebook_id: @me['id']).first

    if @game && @game.has_ended?
      render 'finish'
    elsif @game
      redirect_to game_url(@game)
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end

  private

  def not_found
    redirect_to root_path
  end

end
