class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true

  has_many :contacts,
  dependent: :destroy,
  foreign_key: :user_id,
  class_name: :Contact

  has_many :shared_contacts, through: :contacts, source: :user

  has_many :comments, :as => :commentable
  
end
