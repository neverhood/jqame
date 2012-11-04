class Jqame::NilElector

  # Simple decorator ( the purpose is to avoid constantly checking for #elector_signed_in? )

  def initialize
  end

  # suffrage
  [ :can_vote?, :can_vote_for?, :can_vote_against?, :voted_for?, :voted_against?, :voted?, :owns_suffrage? ].each do |method_name|
    define_method method_name do |votable|
      false
    end
  end

  #favorites
  [ :favorited? ].each do |method_name|
    define_method method_name do |question|
      false
    end
  end

end
