# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  responder_id     :integer          not null
#  question_id      :integer          not null
#  answer_choice_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Response < ActiveRecord::Base
  validates :responder_id, presence: true
  validates :answer_choice_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :respondent_cant_be_author

  belongs_to(
  :answer_choice,
  class_name: :AnswerChoice,
  foreign_key: :answer_choice_id,
  primary_key: :id
  )

  belongs_to(
  :respondent,
  class_name: :User,
  foreign_key: :responder_id,
  primary_key: :id
  )

  has_one :question, through: :answer_choice, source: :question
  has_one :poll, through: :question, source: :poll

  def sibling_responses
    all_responses = question.responses
    all_responses.where([":id IS NOT NULL AND responses.id != :id", {id: self.id}])
  end

  def respondent_has_not_already_answered_question
    responses = sibling_responses.includes(:responder_id)
    if responses.each {|response| response.responder_id.exists?(self.responder_id) }
      errors[:response] << "Respondent already answered question"
    end
  end

  def respondent_cant_be_author
    if self.question.poll.author_id == self.responder_id
      errors[:response] << "Respondent cant respond to own poll"
    end
  end
end

# ClassName => a
# ClassName.includes(:a)

# ClassName => a => [b, c]
# ClassName.includes(a: [:b, :c])

# ClassName => a => b => c
# ClassName.includes(a: { b: :c })
