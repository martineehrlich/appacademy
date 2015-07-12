# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times { User.create!(user_name: Faker::Name.name) }

Poll.create!([{title: "Poll1", author_id: 1}, {title: "Poll2", author_id: 2}])

Question.create!([{poll_id: 1, text: "Question1"},
{poll_id: 1, text: "Question2"},
{poll_id: 1, text: "Question3"},
{poll_id: 2, text: "Question1"},
{poll_id: 2, text: "Question2"}])

AnswerChoice.create!([{question_id: 1, text: "AnswerChoice1"},
{question_id: 1, text: "AnswerChoice2"},
{question_id: 2, text: "AnswerChoice1"},
{question_id: 2, text: "AnswerChoice2"},
{question_id: 4, text: "AnswerChoice1"},
{question_id: 4, text: "AnswerChoice2"}])

Response.create!([{responder_id: 9, answer_choice_id: 1},
{responder_id: 9, answer_choice_id: 2},
{responder_id: 9, answer_choice_id: 3},
{responder_id: 9, answer_choice_id: 4},
{responder_id: 9, answer_choice_id: 5},
{responder_id: 10, answer_choice_id: 1},
{responder_id: 10, answer_choice_id: 3},
{responder_id: 10, answer_choice_id: 5}])
