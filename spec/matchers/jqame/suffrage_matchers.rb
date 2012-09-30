module SuffrageMatchers

  %w(for against).each do |vote_kind|
    # defines #be_able_to_vote_for and #be_able_to_vote_against matchers
    ::RSpec::Matchers.define :"be_able_to_vote_#{vote_kind}" do |votable|
      match do |elector|
        elector.send(:"can_vote_#{vote_kind}?", votable) === true && elector.send(:"vote_#{vote_kind}", votable).valid?
      end

      failure_message_for_should do
        "Expected elector to be able to vote #{vote_kind} votable, but opposite happened"
      end

      failure_message_for_should_not do
        "Expected elector to NOT be able to vote #{vote_kind} votable, but opposite happened"
      end
    end
  end

end
