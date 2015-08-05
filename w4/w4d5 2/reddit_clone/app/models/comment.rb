class Comment < ActiveRecord::Base
  validates :user, :post, presence: true

  belongs_to :user
  belongs_to :post

  has_many(
    :child_comments,
    primary_key: :id,
    foreign_key: :parent_comment_id,
    class_name: :Comment
  )
end
