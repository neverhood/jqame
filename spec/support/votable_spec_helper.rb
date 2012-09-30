module VotableSpecHelper

  def submit_new_question(question)
    visit jqame.new_question_path
    populate_question_attributes(question)

    click_button I18n.t('questions.submit')
  end

  def update_question(attributes)
    populate_question_attributes(attributes)

    click_button I18n.t('questions.submit')
  end

  def submit_new_answer(answer)
    visit jqame.question_path(answer.question)

    click_button I18n.t('answers.submit')
  end

  def update_answer
  end

  private

  def populate_question_attributes(question)
    question = OpenStruct.new(question) if question.is_a?(Hash)

    fill_in 'question_title', with: question.title
    fill_in 'question_body',  with: question.body
  end

  def populate_answer_attributes(answer)
    answer = OpenStruct.new(answer) if answer.is_a?(Hash)

    fill_in 'answer_body',  with: question.body
  end

end
