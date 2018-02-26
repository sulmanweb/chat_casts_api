class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.confirm.subject
  #
  def confirm verification_id
    @verification = Verification.find_by_id(verification_id)
    unless @verification.nil?
      mail to: @verification.user.email, subject: I18n.t('user_mailer.confirm.subject')
    end
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome user_id
    @user = User.find_by_id(user_id)
    unless @user.nil?
      mail to: @user.email, subject: I18n.t('user_mailer.welcome.subject')
    end
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reset.subject
  #
  def reset verification_id
    @verification = Verification.find_by_id(verification_id)
    unless @verification.nil?
      mail to: @verification.user.email, subject: I18n.t('user_mailer.reset.subject')
    end
  end
end
