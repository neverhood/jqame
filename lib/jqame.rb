require "jqame/engine"

require "jqame/suffrage_reputation_logic"
require "jqame/vote_rate"
require "jqame/action_rate"

module Jqame
  mattr_accessor :elector_class, :current_elector

  def current_elector
    send(@@current_elector)
  end

  def elector_signed_in?
    !!current_elector
  end

  def self.elector_string
    @@elector_class.underscore
  end
end
