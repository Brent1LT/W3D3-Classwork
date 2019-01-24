class ShortenedUrl < ApplicationRecord
  validates :short_url, uniqueness: true
  validates :user_id, presence: true

  def self.random_code
    short_url = SecureRandom::urlsafe_base64
    until !ShortenedUrl.exists?(short_url: short_url)
      short_url = SecureRandom::urlsafe_base64
    end 
    short_url
  end 

  def self.generate_short_url(long_url, user)
    ShortenedUrl.create!(
      long_url: long_url, 
      short_url: ShortenedUrl.random_code, 
      user_id: user.id)
  end 

    belongs_to :submitter,
      primary_key: :id,
      foreign_key: :user_id,
      class_name: 'User'
end 