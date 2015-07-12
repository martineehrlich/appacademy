# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string
#  created_at :datetime
#  updated_at :datetime
#  premium    :boolean          default("f")
#

class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true

  has_many :submitted_urls,
    primary_key: :id,
    foreign_key: :submitter_id,
    class_name: :ShortenedUrl

  has_many :visits,
    primary_key: :id,
    foreign_key: :submitter_id,
    class_name: :Visit

  has_many :visited_urls, through: :visits, source: :shortened_url

  def num_urls_created_in_past_minute
    time = 1.minutes.ago
    submitted_urls.where(["created_at > :time", {time: time}]).count
  end
  
end
