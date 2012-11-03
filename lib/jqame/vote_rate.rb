class Jqame::VoteRate
  RATES = {
    question: { upvote: 5 , downvote: -2 },
    answer:   { upvote: 10, downvote: -2 }
  }

  attr_accessor :votable_type, :vote_kind, :rate

  def initialize(vote)
    @votable_type = vote.votable_type.sub('Jqame::', '').underscore.to_sym
    @kind = vote.kind
    @rate = RATES[@votable_type][@kind]
  end
end
