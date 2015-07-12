# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  poll_id    :integer
#  text       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ActiveRecord::Base
  validates :poll_id, presence: true

  has_many(
  :answer_choices,
  class_name: :AnswerChoice,
  foreign_key: :question_id,
  primary_key: :id
  )

  belongs_to(
  :poll,
  class_name: :Poll,
  foreign_key: :poll_id,
  primary_key: :id
  )

  has_many :responses, through: :answer_choices, source: :responses

  def results
    # answer_choices.includes(:responses)
    # results = Hash.new { |hash, key| hash[key] = 0 }
    # answer_choices.each {|answer_choice| results[answer_choice] = answer_choice.responses.length }
    # results

    answer_choices
    .joins('LEFT OUTER JOIN responses as r ON answer_choices.id = r.answer_choice_id')
    .where(['answer_choices.question_id = :id', {id: self.id}])
    .group_by(answer_choices.id)

    #
    # SELECT ac.*, COUNT(r.id)
    # FROM answer_choices AS ac
    # LEFT OUTER JOIN responses r ON ac.id = r.answer_choice_id
    # WHERE ac.question_id = 1
    # GROUP BY ac.id
    #

  end

end
