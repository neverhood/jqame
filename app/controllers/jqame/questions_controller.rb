require_dependency "jqame/application_controller"

module Jqame
  class QuestionsController < ApplicationController

    respond_to :html, :json
    before_filter :find_question!, only: [ :show, :edit, :update, :destroy ]

    def index
      @questions = Question.all
    end

    def show
    end

    def new
      @question = Question.new
    end

    def create
      @question = Question.create(params[:question])

      respond_with @question
    end

    def update
    end

    def edit
    end

    def destroy
    end

    private
    def find_question!
      @question = Question.where(id: params[:id]).first
      render_not_found if @question.nil?
    end

  end
end
