class Jqame::VoteRate
  RATES = {
    question: { upvote: 5 , downvote: -3 },
    answer:   { upvote: 10, downvote: -5 }
  }

  attr_accessor :votable_type, :vote_kind, :new

  def initialize(vote, new)
    @votable_type = vote.votable_type.sub('Jqame::', '').underscore.to_sym
    @kind = vote.kind
    @new = new
  end

  def rate
    new ? RATES[@votable_type][@kind] : - RATES[@votable_type][@kind]
  end
end
