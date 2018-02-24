class User < ApplicationRecord
  has_secure_password

  # Email Validations
  validates :email, presence: true, uniqueness: true, format: {with: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/, message: I18n.t('error.format_email')}

  # Username Validations
  validates :username, presence: true, uniqueness: true, format: {with: /\A([a-z\d_]){1,15}\z/, message: I18n.t('error.format_username')}

  # validates password length and regex
  validates :password, presence: true, on: :create
  validates :password, format: {with: /\A(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[\W]).{8,72}\z/, message: I18n.t('error.format_password')}, if: :password

  after_create :send_welcome_mail

  private

  def send_welcome_mail
    UserMailer.welcome(self.id).deliver_later
  end
end
