# == Schema Information
#
# Table name: visits
#
#  id               :integer          not null, primary key
#  shortened_url_id :integer
#  submitter_id     :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Visit < ActiveRecord::Base
  validates :submitter_id, presence: true
  validates :shortened_url_id, presence: true

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :submitter_id,
    class_name: :User

  belongs_to :shortened_url,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: :ShortenedUrl

  def self.record_visit!(user, shortened_url)
    Visit.new(submitter_id: user.id, shortened_url_id: shortened_url.id).save!
  end
end
