require_dependency "jqame/application_controller"

module Jqame
  class QuestionsController < ApplicationController

    respond_to :html, :json

    before_filter :find_question!, only: [ :show, :edit, :update, :destroy, :answer ]
    before_filter :authenticate_elector!, only: [ :new, :create, :update, :edit, :destroy ]
    before_filter :require_question_owner!, only: [ :update, :edit, :destroy ]

    def index
      @questions = Question.all
    end

    def show
      Jqame::QuestionView.store!(@question, current_elector) if elector_signed_in?
    end

    def new
      @question = Question.new
    end

    def create
      @question = current_elector.questions.create(question_params)
      respond_with @question
    end

    def update
      @question.update_attributes(question_params)
      respond_with @question
    end

    def edit
    end

    def destroy
      @question.destroy
      respond_with @question
    end

    def answer
      @question.answer_with current_elector, params.require(:answer).permit(:body)
      respond_with @question
    end


    private

    def question_params
      params.require(:question).permit(:body, :title)
    end

  end
end
