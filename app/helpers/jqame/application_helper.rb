module Jqame
  module ApplicationHelper

    def error_messages_for model
      return "" if model.errors.empty?

      messages = model.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
      sentence = I18n.t("errors.messages.not_saved",
                        :count => model.errors.count,
                        :resource => model.class.model_name.human.downcase)

      html = <<-HTML
      <div class="alert alert-error" id="error-explanation">
        <ul>#{messages}</ul>
      </div>
      HTML

      html.html_safe
    end

    def navbar_link(text, path)
      "<li class='#{ current_page?(path) ? "active" : ""}'> #{ link_to text, path } </li>".html_safe
    end

    def page_header(text)
      "<div class='page-header'> <h3> #{text} </h3> </div>".html_safe
    end

  end
end
