class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
  :recoverable, :rememberable, :trackable, :validatable
  has_many :posts, dependent: :destroy

  after_create :welcome_email

  def welcome_email
    UserMailer.welcome_email(self).deliver_later
  end

  def active_for_authentication?
    super && !deleted_at
  end

  def assign_auth_token!
    loop do
      self.auth_token = SecureRandom.base64(50)
      break unless User.exists?(auth_token: auth_token)
    end
    save!
  end

  protected

  def confirmation_required?
    false
  end
end
