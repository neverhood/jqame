module SuffrageMatchers

  %w(for against).each do |vote_kind|
    # defines #be_able_to_vote_for and #be_able_to_vote_against matchers
    Rspec::Matchers.define :"be_able_to_vote_#{vote_kind}" do |votable|
      match do |employee|
        employee.send(:"can_vote_#{vote_kind}?", votable) === true && employee.send(:"vote_#{vote_kind}", votable).valid?
      end

      failure_message_for_should do
        "Expected employee to be able to vote #{vote_kind} votable, but opposite happened"
      end

      failure_message_for_should_not do
        "Expected employee to NOT be able to vote #{vote_kind} votable, but opposite happened"
      end
    end
  end

end
