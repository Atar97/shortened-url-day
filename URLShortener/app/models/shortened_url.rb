# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  short_url  :string           not null
#  long_url   :string           not null
#

class ShortenedUrl < ApplicationRecord
  validates :user_id, :long_url, :short_url, presence: true
  validates :short_url, uniqueness: true

  def self.random_code
    code = SecureRandom.urlsafe_base64
    while exists?(short_url: code)
      code = SecureRandom.urlsafe_base64
    end
    code
  end

  def self.make_from_user!(options)
    ShortenedUrl.create(user_id: options[:user_id],
      long_url: options[:long_url],
      short_url: ShortenedUrl.random_code)
  end

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :visits,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: :Visit

  has_many :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :user

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.visitors.select(:user_id).count
  end

  def num_recent_uniques
    self.visitors.select(:user_id).distinct.where(["visits.updated_at > ?", 10.minutes.ago]).count
  end

end
