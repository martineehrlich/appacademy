class Post < ActiveRecord::Base
  validates :user, :title, presence: true
  belongs_to :user
  has_many :moderators, through: :subs, source: :moderator
  has_many :post_subs, inverse_of: :post
  has_many :subs, through: :post_subs
  has_many :comments
end
