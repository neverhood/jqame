module Jqame::SuffrageReputationLogic

  extend self

  def self.answer_accepted! question, answer
    _answer_accepted!(question, answer)
  end

  def self.answer_unaccepted! question, answer
    _answer_unaccepted!(question, answer)
  end

  def self.vote_created! vote
    _downvoted!(vote) if vote.downvote?
    _store_vote! vote
  end

  private

  def _answer_unaccepted!(question, answer)
    return if question.elector_id == answer.elector_id # unaccepted own answer

    Jqame::ReputationPoint.where(elector_id: answer.elector_id,
                                 question_id: answer.question_id,
                                 action: Jqame::ReputationPoint::ACTIONS[:accepted]).destroy_all

    Jqame::ReputationPoint.where(elector_id: question.elector_id,
                                 question_id: question.id,
                                 action: Jqame::ReputationPoint::ACTIONS[:accept]).destroy_all
  end

  # When answer is accepted both question owner and answer owner are given some reputation
  def _answer_accepted!(question, answer)
    return if question.elector_id == answer.elector_id # accepted own answer

    Jqame::ReputationPoint.create(elector_id: answer.elector_id,
                                  question_id: answer.question_id,
                                  action: Jqame::ReputationPoint::ACTIONS[:accepted])

    Jqame::ReputationPoint.create(elector_id: question.elector_id,
                                  question_id: question.id,
                                  action: Jqame::ReputationPoint::ACTIONS[:accept])
  end

  def _store_vote! vote, created = true
    # Owner of votable will be granted/withdrawn some reputation upon new vote ( depending on vote kind )
    vote.reputation_points.create(question_id: vote.question_id,
                                  elector_id: vote.votable.elector_id,
                                  reputation_amount: Jqame::VoteRate.new(vote).rate,
                                  action: vote.kind
                                 )
  end

  # When user downvotes something, some reputation will be withdrawn
  def _downvoted! vote
    vote.reputation_points.create(question_id: vote.question_id,
                                  elector_id: vote.elector_id,
                                  action: Jqame::ReputationPoint::ACTIONS[:downvoted])
  end

end
