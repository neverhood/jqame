module SuffrageMatchers

  RSpec::Matchers.define :be_able_to_vote_for do |votable|
      match do |employee|
        employee.can_vote_for?(votable) === true && employee.vote_for(votable).valid?
      end

      failure_message_for_should do
        "Expected employee to be able to vote for votable, but opposite happened"
      end

      failure_message_for_should_not do
         "Expected employee to NOT be able to vote for votable, but opposite happened"
      end
  end

end
