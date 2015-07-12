# == Schema Information
#
# Table name: taggings
#
#  id               :integer          not null, primary key
#  shortened_url_id :integer
#  topic_id         :integer
#

class Tagging < ActiveRecord::Base
    validates :shortened_url_id, presence: true
    validates :topic_id, presence: true

    belongs_to :topic,
      primary_key: :id,
      foreign_key: :topic_id,
      class_name: :TagTopic

      belongs_to :url,
        primary_key: :id,
        foreign_key: :shortened_url_id,
        class_name: :ShortenedUrl
end
