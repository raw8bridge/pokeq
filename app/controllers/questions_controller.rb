class QuestionsController < ApplicationController
  before_action :set_question, only: %i[ show edit update destroy ]
  before_action :set_choices, only: %i[ edit ]

  # GET /questions
  def index
    @questions = Question.all
  end

  # GET /questions/1
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  def create
    @question = Question.new(question_params)

    if @question.save
      # redirect_to @question, notice: "Question was successfully created."
      redirect_to new_question_choices_path(question_id: @question.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /questions/1
  def update
    if @question.update(question_params)
      redirect_to @question, notice: "Question was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /questions/1
  def destroy
    @question.destroy!
    redirect_to questions_url, notice: "Question was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    def set_choices
      @choices = set_question.choices
    end

    # Only allow a list of trusted parameters through.
    def question_params
      params.require(:question).permit(:body)
    end
end
