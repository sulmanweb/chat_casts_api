require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
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
end
