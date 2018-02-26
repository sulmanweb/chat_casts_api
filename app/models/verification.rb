class Verification < ApplicationRecord
  belongs_to :user

  enum v_type: [:confirm, :reset_password]
  enum status: [:pending, :approved, :late]

  validates :status, presence: true, inclusion: {in: statuses.keys}
  validates :v_type, presence: true, inclusion: {in: v_types.keys}
  validates :token, presence: true, uniqueness: true, length: {is: VERIFY_TOKEN_LENGTH, message: I18n.t('error.length_v_token', len: VERIFY_TOKEN_LENGTH)}

  ## MODEL FUNCTIONS CALLINGS
  before_validation :generate_token, on: :create

  after_create :send_mail

  # Generate random unique utoken for the model
  def generate_token
    self.token = loop do
      random_token = SecureRandom.base58(VERIFY_TOKEN_LENGTH)
      break random_token unless Verification.exists?(token: random_token)
    end
  end

  # make a confirmation email
  def self.build_confirm user
    Verification.new(v_type: :confirm, status: :pending, user: user)
  end

  # make reset password verification
  def self.build_reset user
    Verification.new(v_type: :reset_password, status: :pending, user: user)
  end

  # search token in system
  def self.search_token token, v_type
    return nil if !Verification.v_types.keys.include? v_type
    v = Verification.find_by(token: token, status: :pending, v_type: v_type)
    return nil if v.nil?
    if v.v_type == 'confirm' && v.created_at + CONFIRMATION_TIME_MAX.days < Time.zone.now
      v.update(status: :late)
      return nil
    elsif v.v_type == 'reset_password' && v.created_at + RESET_TIME_MAX.hours < Time.zone.now
      v.update(status: :late)
      return nil
    else
      v.update(status: :approved)
      return v
    end
  end

  private

  def send_mail
    if self.v_type == 'confirm'
      UserMailer.confirm(self.id).deliver_later
    elsif self.v_type == 'reset_password'
      UserMailer.reset(self.id).deliver_later
    end
  end
end
