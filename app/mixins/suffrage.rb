module Suffrage
  # A simple set of methods for external application's `elector` model
  # Mounting application should include this module explicitly
  #
  extend self

  def vote_for votable
    votes.new(votable: votable)
  end

  def vote_against votable
    votes.new(votable: votable, upvote: false)
  end

  def vote_for! votable
    cancel_vote_for(votable) if voted_against?(votable)

    vote_for(votable).tap { |vote| vote.save }
  end

  def vote_against! votable
    cancel_vote_for(votable) if voted_for?(votable)

    vote_against(votable).tap { |vote| vote.save }
  end

  def voted_on? votable
    votes.on(votable).any?
  end

  def can_vote? votable
    # Currently we don't have any constraints, so everyone can vote ( except the votable owner )
    not votable_author? votable
  end

  def can_vote_for? votable
    not votable_author?(votable) and not voted_for?(votable)
  end

  def can_vote_against? votable
    not votable_author?(votable) and not voted_against?(votable)
  end

  def votable_author? votable
    votable.elector_id == id
  end

  def voted_for? votable
    votes.on(votable).where(upvote: true).any?
  end

  def voted_against? votable
    votes.on(votable).where(upvote: false).any?
  end

  def cancel_vote_for votable
    votes.on(votable).destroy_all
  end

  def dates_when_reputation_changed limit = 25
    date_predicate = "DATE('jqame_votes'.'created_at')"
    Jqame::Vote.affecting_votables_of(self).group(date_predicate).limit(limit).
      select(date_predicate + " AS date").map { |record| Date.parse(record.date) }
  end

  def owns_suffrage? suffrage
    return false unless [ Jqame::Answer, Jqame::Comment, Jqame::Question ].include?(suffrage.class)
    suffrage.elector_id == id
  end

  module ClassMethods
  end

  def self.included(base)
    base.has_many :questions, class_name: 'Jqame::Question', foreign_key: 'elector_id', dependent: :destroy
    base.has_many :answers, class_name: 'Jqame::Answer', foreign_key: 'elector_id', dependent: :destroy
    base.has_many :votes, class_name: 'Jqame::Vote', foreign_key: 'elector_id', dependent: :destroy
    base.has_many :comments, class_name: 'Jqame::Comment', foreign_key: 'elector_id', dependent: :destroy
  end

end
