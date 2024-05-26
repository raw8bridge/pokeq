class ChoicesController < ApplicationController
    before_action :set_choices, only: %i[ new create edit update ]

    # GET /choices/new
    def new
      redirect_to action: :edit if choices_present?
      @form_choice = Form::Choice.new(question_id: params[:question_id])
    end

    # GET /choices/1/edit
    def edit
      @form_choice = Form::Choice.new(choices: @choices)
    end

    # POST /choices
    def create
      @form_choice = Form::Choice.new(question_id: params[:question_id], choices: @choices, attributes: form_choice_params)

      if @form_choice.save
        redirect_to @question, notice: "choice was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /choices/1
    def update
      if @choice.update(choice_params)
        redirect_to @question, notice: "choice was successfully updated.", status: :see_other
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_choices
        @choices = set_question.choices
      end

      def set_question
        @question = Question.find(params[:question_id])
      end

      # Only allow a list of trusted parameters through.
      def form_choice_params
        params.require(:form_choice).permit(choices_attributes: [:body])
      end

      # データが存在するときに new されるのを防ぐ
      def choices_present?
        set_choices.present?
      end
  end
