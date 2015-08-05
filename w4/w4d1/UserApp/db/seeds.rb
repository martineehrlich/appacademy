# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.new(username: "Bob").save
User.new(username: "kat").save
User.new(username: "aa").save
User.new(username: "tab").save
User.new(username: "pop").save
User.new(username: "dog").save
User.new(username: "ned").save
User.new(username: "happy").save

Contact.new(name: "mary", email: "gmail", user_id: 1).save
Contact.new(name: "joe", email: "gil1", user_id: 1).save
Contact.new(name: "srah", email: "gmail2", user_id: 2).save
Contact.new(name: "tim", email: "gmail3", user_id: 2).save
Contact.new(name: "jake", email: "gmail5", user_id: 3).save
Contact.new(name: "sam", email: "gmail6", user_id: 4).save

ContactShare.new(user_id: 1, contact_id: 1).save
ContactShare.new(user_id: 1, contact_id: 2).save
ContactShare.new(user_id: 2, contact_id: 3).save
ContactShare.new(user_id: 2, contact_id: 5).save
ContactShare.new(user_id: 3, contact_id: 5).save
ContactShare.new(user_id: 4, contact_id: 2).save
