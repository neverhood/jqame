module Jqame
  class ReputationPoint < ActiveRecord::Base

    belongs_to :elector, class_name: Jqame.elector_class
    belongs_to :question
    belongs_to :vote

    ACTIONS = {
      upvote: 1,
      downvote: 2,
      accept: 3,
      accepted: 4,
      downvoted: 5
    }

    def action
      ACTIONS.invert[ read_attribute(:action) ].to_s.inquiry
    end

    before_save  :assign_reputation_amount!, if: -> { %w(accept accepted downvoted).include?(action) }

    after_create :increment_elector_reputation!
    after_destroy :decrement_elector_reputation!

    private

    def assign_reputation_amount!
      self.reputation_amount = Jqame::ActionRate.new(action).rate
    end

    def increment_elector_reputation!
      elector.increment! :reputation, reputation_amount
    end

    def decrement_elector_reputation!
      elector.increment! :reputation, -reputation_amount
    end

  end
end
