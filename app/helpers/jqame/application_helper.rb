module Jqame
  module ApplicationHelper

    def error_messages_for model
      return "" if model.errors.empty?

      messages = model.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
      sentence = I18n.t("errors.messages.not_saved",
                        :count => model.errors.count,
                        :resource => model.class.model_name.human.downcase)

      html = <<-HTML
      <div class="alert alert-error" id="error_explanation">
        <h2>#{sentence}</h2>
        <ul>#{messages}</ul>
      </div>
      HTML

      html.html_safe
    end

  end
end
