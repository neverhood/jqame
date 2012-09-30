module Jqame
  class ApplicationController < ActionController::Base

    helper_method :render_not_found, :render_permission_denied, :current_elector, :elector_signed_in?

    alias_method :authenticate_elector!, :"authenticate_#{Jqame.elector_string}!"
    alias_method :elector_signed_in?, :"#{Jqame.elector_string}_signed_in?"

    def render_not_found
      raise ActionController::RoutingError.new('Not Found')
    end

    def render_permission_denied
      redirect_to root_path, notice: I18n.t('common.permission_denied')
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
      record = model.where(id: params[:id] || params[:"#{model_name}_id"]).first

      if record.nil?
        render_not_found
      else
        instance_variable_set "@#{model_name}", record
      end
    end

  end
end
