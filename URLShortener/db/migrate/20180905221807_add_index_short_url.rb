class AddIndexShortUrl < ActiveRecord::Migration[5.1]
  def change
    add_index :shortened_urls, :short_url, unique: true
  end
end
