class GamesController < ApplicationController
  before_filter :load_facebook_user

  rescue_from ActiveRecord::RecordNotFound, :with => :not_found

  # GET /games/1
  def show
    @game = Game.find(params[:id])

    @index = @game.current_question_index
    @question = @game.questions[@index]

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(params[:game])

    @game.current_question_index = 0
    @game.questions = Question.all.shuffle[0..9]

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render json: @game, status: :created, location: @game }
      else
        format.html { render action: "new" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /games/:id/questions/:question_id/answer
  def answer
    @game = Game.find(params[:id])

    current_question = @game.questions[@game.current_question_index]
    @game.answer_question(current_question, params[:answer])

    @game.save

    @index = @game.current_question_index
    @question = @game.questions[@index]

    if @index < @game.questions.size
      render 'show'
    else
      redirect_to finish_url(@game), :status => :found
    end
  end

  # GET /games/:id/finish
  def finish
    @game = Game.find(params[:id])
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
