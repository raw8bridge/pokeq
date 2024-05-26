class Form::Choice < Form::Base
  FORM_COUNT = 4
  attr_accessor :choices
  attr_accessor :question_id

  def initialize(question_id: nil, choices: nil, attributes: {})
    # TODO: question_id を必須とする
    raise if question_id.blank? && choices.blank?
    @question_id = question_id

    if choices.blank?
      @choices = FORM_COUNT.times.map { Choice.new(question_id: @question_id) }
    else
      @choices = choices
    end

    super attributes
  end

  def choices_attributes=(attributes)
    @choices.each_with_index do |choice, i|
      choice.attributes = attributes[i.to_s]
    end
  end

  def save
    Choice.transaction do
      self.choices.map do |choice|
        choice.save
      end
    end
    return true
  rescue => e
    return false
  end
end
