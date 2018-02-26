# Preview all emails at http://localhost:3000/rails/mailers/user
class UserPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user/confirm
  def confirm
    UserMailer.confirm(Verification.last.id)
  end

  # Preview this email at http://localhost:3000/rails/mailers/user/welcome
  def welcome
    UserMailer.welcome(User.last.id)
  end

  # Preview this email at http://localhost:3000/rails/mailers/user/reset
  def reset
    UserMailer.reset(Verification.last.id)
  end

end
