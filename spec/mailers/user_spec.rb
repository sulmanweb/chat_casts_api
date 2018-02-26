require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "confirm" do
    let(:verification) {FactoryBot.create(:verification)}
    let(:mail) {UserMailer.confirm(verification.id)}

    it "sends confirmation email to the user's email address" do
      expect(mail.to).to eql [verification.user.email]
    end

    it "send confirmation email from default mailer" do
      expect(mail.from).to eql [DEFAULT_MAILER]
    end
  end

  describe "welcome_email" do
    let(:user) {FactoryBot.create(:user)}
    let(:mail) {UserMailer.welcome(user.id)}

    it "sends welcome email to the user's email address" do
      expect(mail.to).to eql [user.email]
    end

    it "send welcome email from default mailer" do
      expect(mail.from).to eql [DEFAULT_MAILER]
    end
  end

  describe "reset" do
    let(:verification) {FactoryBot.create(:verification)}
    let(:mail) {UserMailer.confirm(verification.id)}

    it "sends reset password email to the user's email address" do
      expect(mail.to).to eql [verification.user.email]
    end

    it "send reset password email from default mailer" do
      expect(mail.from).to eql [DEFAULT_MAILER]
    end
  end

end
