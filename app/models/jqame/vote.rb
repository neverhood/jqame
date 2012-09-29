module Jqame
  class Vote < ActiveRecord::Base
    class << self
      attr_accessor :rates
    end

    # Amount of reputation to be granted/withdrawn for an employee upon upvote/downvote of his question or answer
    @rates = {
      question: { upvote: 5 , downvote: -3 },
      answer:   { upvote: 10, downvote: -5 }
    }

    # Returns a collection of votes that affected #employee reputation
    #def self.affecting_votables_of employee, records_limit = 5
      #votes, questions, answers = [ Jqame::Vote, Jqame::Question, Jqame::Answer ].map(&:arel_table)

      #find_by_sql( votes.project(votes[Arel.star]).
        #join(questions, Arel::Nodes::OuterJoin).on(outer_join_votable_predicates(questions)).
        #join(answers, Arel::Nodes::OuterJoin).on(outer_join_votable_predicates(answers)).
          #where(questions[:employee_id].eq(employee.id).or(answers[:employee_id].eq(employee.id))).
        #order(votes[:created_at].desc).
        #take(records_limit).to_sql )
    #end

    def self.affecting_votables_of employee, limit = 5
    end

    # Associations
    belongs_to :votable, polymorphic: true
    belongs_to :employee

    attr_accessible :votable, :upvote

    # Scopes
    scope :on,     -> votable { where(votable_id: votable.id, votable_type: votable.class.model_name) }
    scope :recent, -> count = 5 { limit(count).order('jqame_votes.created_at DESC') }
    scope :affecting_votables_of, -> employee, limit = 5 {
      joins("LEFT OUTER JOIN 'jqame_questions' ON ( votable_type = 'Jqame::Question' AND votable_id = 'jqame_questions'.'id' )")
      .joins("LEFT OUTER JOIN 'jqame_answers' ON ( votable_type = 'Jqame::Answer' AND votable_id = 'jqame_answers'.'id' )").
        where([ '( "jqame_questions"."employee_id" = ? OR "jqame_answers"."employee_id" = ? )', employee.id, employee.id ]).
        order('"jqame_votes"."created_at" DESC').
        limit(limit)
    }
    scope :affecting_votables_by_date, -> employee, date {
      affecting_votables_of(employee).where( ["DATE('jqame_votes'.'created_at') = ?", date])
    }

    # Validations
    validates :employee_id, uniqueness: { scope: [ :votable_id, :votable_type, :upvote ] }

    # Callbacks
    # Votable
    before_create  :update_votable_rating_before_create
    before_destroy :update_votable_rating_before_destroy
    # Employee
    before_create  :update_employee_reputation_before_create
    before_destroy :update_employee_reputation_before_destroy

    def votable= votable
      tap do |vote|
        vote.votable_id = votable.id
        vote.votable_type = votable.class.model_name
      end
    end

    def downvote?
      not upvote?
    end

    def kind
      upvote?? :upvote : :downvote
    end

    def reputation_value
      self.class.rates[ votable_type.sub('Jqame::', '').underscore.to_sym ][ kind ]
    end

    private

    def update_votable_rating_before_create
      votable.increment!(:current_rating, ( upvote?? 1 : -1 ))
    end

    def update_votable_rating_before_destroy
      votable.increment!(:current_rating, ( upvote?? -1 : 1 ))
    end

    def update_employee_reputation_before_create
      modifier = Vote.rates[votable.class.votable_type][kind]

      votable.employee.increment!(:reputation, modifier)
    end

    def update_employee_reputation_before_destroy
      modifier = Vote.rates[votable.class.votable_type][kind]

      votable.employee.increment!(:reputation, - modifier)
    end

    def self.outer_join_votable_predicates(votables)
      arel_table[:votable_id].eq(votables[:id]).
        and(arel_table[:votable_type].eq(votables.engine.to_s))
    end

  end
end
