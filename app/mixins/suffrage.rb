module Suffrage
  # A simple set of methods for external application's `employee` model
  # Mounting application should include this module explicitly
  #
  extend self

  def vote_for votable
    votes.new(votable: votable)
  end

  def vote_for! votable
    vote_for(votable).tap { |vote| vote.save }
  end

  def vote_against votable
    votes.new(votable: votable, upvote: false)
  end

  def vote_against! votable
    vote_against(votable).tap { |vote| vote.save }
  end

  def voted_on? votable
    votes.on(votable).any?
  end

  def can_vote_for? votable
    not votable_author?(votable) and not voted_for?(votable)
  end

  def can_vote_against? votable
    not votable_author?(votable) and not voted_against?(votable)
  end

  def votable_author? votable
    votable.employee_id == id
  end

  def voted_for? votable
    votes.on(votable).where(upvote: true).any?
  end

  def voted_against? votable
    votes.on(votable).where(upvote: false).any?
  end

  def self.included(base)
    base.has_many :questions, class_name: 'Jqame::Question'
    base.has_many :answers, class_name: 'Jqame::Answer'
    base.has_many :votes, class_name: 'Jqame::Vote'
  end

  module ClassMethods
  end
end
