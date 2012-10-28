module Jqame
  class ApplicationController < ActionController::Base

    helper_method :current_question?, :current_elector, :elector_signed_in?

    alias_method :authenticate_elector!, :"authenticate_#{Jqame.elector_string}!"
    alias_method :elector_signed_in?, :"#{Jqame.elector_string}_signed_in?"

    def current_question
      @current_question ||= @question
    end

    def render_not_found
      raise ActionController::RoutingError.new('Not Found')
    end

    def render_permission_denied
      redirect_to root_path, notice: I18n.t('common.permission_denied')
    end

    def require_question_owner! question = nil
      unless elector_signed_in? and current_elector.owns_suffrage?(question || @question)
        render_permission_denied and return
      end
    end

    def require_answer_owner! answer = nil
      unless elector_signed_in? and current_elector.owns_suffrage?(answer || @answer)
        render_permission_denied and return
      end
    end

    def find_question!
      _find_record! Question
    end

    def find_answer!
      _find_record! Answer
    end

    def current_elector
      send(:"current_#{Jqame.elector_string}")
    end

    private

    def _find_record! model
      model_name = model.model_name.sub(/.*::/, '').underscore
      record = model.where(id: ( params[:"#{model_name}_id"] || params[:id] )).first

      if record.nil?
        render_not_found
      else
        instance_variable_set "@#{model_name}", record
      end
    end

  end
end
