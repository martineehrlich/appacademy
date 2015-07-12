# == Schema Information
#
# Table name: shortened_urls
#
#  id           :integer          not null, primary key
#  long_url     :string
#  short_url    :string
#  submitter_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'securerandom'

class ShortenedUrl < ActiveRecord::Base
  validates :long_url, presence: true, length: {maximum: 1024}
  validates :short_url, presence: true, uniqueness: true
  validates :submitter_id, presence: true
  validate :cant_submit_more_than_five_in_one_minute
  validate :non_premium_user_cant_submit_more_than_five

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :submitter_id,
    class_name: :User

  has_many :visits,
    dependent: :destroy,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: :Visit

  has_many :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :submitter

  has_many :taggings,
    dependent: :destroy,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: :Tagging

  has_many :topics, through: :taggings, source: :topic


  def self.random_code
    test_url = SecureRandom.urlsafe_base64
    while ShortenedUrl.exists?(short_url: test_url)
      test_url = SecureRandom.urlsafe_base64
    end
    test_url
  end

  def self.create_for_user_and_long_url!(user, long_url)
    # debugger
    short_url = random_code
    url = ShortenedUrl.new(
      submitter_id: user.id,
      short_url: short_url,
      long_url: long_url)
    url.save!
    url
  end

  def num_clicks
    Visit.where(shortened_url_id: id).count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    time = 10.minutes.ago

    visitors.where(["visits.created_at > :time", {time: time}]).count
  end

  def self.prune(n)
    time = n.minutes.ago
    unvisited_urls = self.where(["shortened_urls.created_at < :time", {time: time}])
    unvisited_urls.destroy_all
  end

  private

  def non_premium_user_cant_submit_more_than_five
    user = User.find_by_id(submitter_id)
    unless user.premium || user.submitted_urls.count < 5
      errors[:submitter_id] << "can't submit more than five. you should upgrade to premium"
    end
  end

  def cant_submit_more_than_five_in_one_minute
    user = User.find_by_id(submitter_id)
    unless user.num_urls_created_in_past_minute < 5
      errors[:submitter_id] << "can't submit more than 5 urls per minute"
    end
  end

end
