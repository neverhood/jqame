module Jqame
  class Vote < ActiveRecord::Base

    def downvote?
      not upvote?
    end

  end
end
