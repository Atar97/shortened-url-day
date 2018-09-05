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


end
