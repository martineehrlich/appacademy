class Contact < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :user_id, presence: true

  has_many :comments, :as => :commentable

  belongs_to :user,
  foreign_key: :user_id,
  class_name: :User

  has_many :shared_users, through: :user, source: :contacts
end
