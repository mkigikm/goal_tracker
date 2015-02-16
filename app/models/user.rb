class User < ActiveRecord::Base
  validates :name, :password_digest, :session_token, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}
  validates :name, uniqueness: true

  attr_reader :password

  def password=(password)
    @password = password
  end
end
