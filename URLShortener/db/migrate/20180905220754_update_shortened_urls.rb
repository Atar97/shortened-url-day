class UpdateShortenedUrls < ActiveRecord::Migration[5.1]
  def change
    remove_column :shortened_urls, :short_url
    remove_column :shortened_urls, :long_url

    add_column :shortened_urls, :short_url, :string, null: false
    add_column :shortened_urls, :long_url, :string, null: false
  end
end
