module Jqame
  class Vote < ActiveRecord::Base

    belongs_to :votable, polymorphic: true
    belongs_to :employee

    def downvote?
      not upvote?
    end

  end
end
