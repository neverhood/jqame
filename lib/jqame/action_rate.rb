class Jqame::ActionRate

  RATES = {
    downvoted: -2,
    accept: 2,
    accepted: 15
  }

  attr_accessor :action, :rate

  def initialize(action)
    @action = action.to_sym
    @rate = RATES[@action]
  end

end
