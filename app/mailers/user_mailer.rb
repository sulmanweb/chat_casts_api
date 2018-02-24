class UserMailer < ApplicationMailer
  def welcome user_id
    @user = User.find_by_id(user_id)
    unless @user.nil?
      mail to: @user.email, subject: I18n.t('user_mailer.welcome.subject')
    end
  end
end
