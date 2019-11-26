class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
  :recoverable, :rememberable, :trackable, :validatable
  has_many :posts

  after_create :welcome_email

  def welcome_email
    UserMailer.welcome_email(self).deliver_later
  end

  def soft_delete
    update_attribute(:deleted_at, Time.current)
  end

  def active_for_authentication?
    super && !deleted_at
  end

  def inactive_message
    !deleted_at ? super : :deleted_account
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
