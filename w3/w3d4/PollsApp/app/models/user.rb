# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  user_name  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true

  has_many(
  :authored_polls,
  class_name: :Poll,
  foreign_key: :author_id,
  primary_key: :id
  )

  has_many(
  :responses,
  class_name: :Response,
  foreign_key: :responder_id,
  primary_key: :id
  )

end
