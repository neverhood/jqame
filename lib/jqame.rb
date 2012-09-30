require "jqame/engine"

module Jqame
  mattr_accessor :elector_class, :current_elector, :elector_string

  def current_elector
    send(@@current_elector)
  end

  def elector_signed_in?
    !!current_elector
  end

  def elector_string
    elector_class.underscore
  end

end
