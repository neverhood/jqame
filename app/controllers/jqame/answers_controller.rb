require_dependency "jqame/application_controller"

module Jqame
  class AnswersController < ApplicationController

    before_filter :find_answer!, only: [ :edit, :update, :destroy ]

    def new
    end

    def create
    end

    def destroy
    end

    def update
    end

    def edit
    end

    private
    def find_answer!
      @answer = Anwer.where(id: params[:id]).first
      render_not_found if @answer.nil?
    end

  end
end
