module Jqame::SuffrageReputationLogic

  extend self

  mattr_accessor :vote_rates, :action_rates

  @@vote_rates = {
    question: { upvote: 5 , downvote: -3 },
    answer:   { upvote: 10, downvote: -5 }
  }

  @@action_rates = {
    downvote: -2,
    accept: 2,
    accepted: 15
  }

  def self.answer_accepted! question, answer
    _amend_electors_reputation_upon_answer_accept( answer.elector, question.elector )
  end

  def self.answer_unaccepted! question, answer
    _amend_electors_reputation_upon_answer_accept( answer.elector, question.elector, false )
  end

  def self.vote_created! vote
    _amend_electors_reputation_upon_vote(vote)
  end

  def self.vote_destroyed! vote
    _amend_electors_reputation_upon_vote(vote, false)
  end

  private

  # Unless elector accepted his own question, reputation of both question and answer owners will be amended
  def _amend_electors_reputation_upon_answer_accept(answer_owner, question_owner, accepted = true)
    if answer_owner.id != question_owner.id
      answer_owner_reputation_modifier = accepted ? action_rates[:accepted] : -action_rates[:accepted]
      question_owner_reputation_modifier = accepted ? action_rates[:accept] : -action_rates[:accept]

      answer_owner.increment!(:reputation, answer_owner_reputation_modifier)
      question_owner.increment!(:reputation, question_owner_reputation_modifier)
    end
  end

  def _amend_electors_reputation_upon_vote vote, created = true
    votable = vote.votable
    modifier = created ? vote_rates[votable.class.votable_type][vote.kind] : -vote_rates[votable.class.votable_type][vote.kind]

    votable.elector.increment!(:reputation, modifier)
  end

end
