class User < ActiveRecord::Base
  validates :name, :password_digest, :session_token, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}
  validates :name, uniqueness: true

  attr_reader :password

  after_initialize :ensure_session_token

  def self.find_by_credentials(name, password)
    user = User.find_by(name: name)
    user = nil unless user && user.is_password?(password)
    user
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def password_digest
    BCrypt::Password.new(super)
  end

  def is_password?(password)
    password_digest.is_password?(password)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    save!
  end

  private
  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
end
