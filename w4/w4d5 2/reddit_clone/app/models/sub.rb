class Sub < ActiveRecord::Base
  validates :title, :description, :moderator, presence: true
  validates :title, uniqueness: true


  belongs_to(
    :moderator,
    primary_key: :id,
    foreign_key: :user_id,
    dependent: :destroy,
    class_name: :User
  )
  has_many :post_subs, inverse_of: :sub
  has_many :posts, through: :post_subs
end
