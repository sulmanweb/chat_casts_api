require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#username" do
    it {is_expected.to validate_presence_of(:username)}
    it {is_expected.to allow_value("sbaig").for(:username)}
    it {is_expected.to allow_value("sbaig1").for(:username)}
    it {is_expected.to allow_value("sba_ig").for(:username)}
    it {is_expected.to_not allow_value("sba ig").for(:username)}
    it {is_expected.to_not allow_value("sb@aig").for(:username)}
    it {is_expected.to_not allow_value("sb!aig").for(:username)}
  end

  describe "#email" do
    it {is_expected.to validate_presence_of(:email)}
    it {is_expected.to allow_value("sbaigweb@gmail.com").for(:email)}
    it {is_expected.to allow_value("sulman.baig@synnapps.com").for(:email)}
    it {is_expected.to_not allow_value("sulman baig@gmail.com").for(:email)}
    it {is_expected.to_not allow_value("sbaig@gmail@com").for(:email)}
    it {is_expected.to_not allow_value("sbaig@synnapps").for(:email)}
  end

  describe '#password' do
    it {is_expected.to validate_presence_of(:password).on(:create)}
    it {is_expected.to allow_value("abcd@1234").for(:password)}
    it {is_expected.to_not allow_value("abcdefg@").for(:password)}
    it {is_expected.to_not allow_value("abcdefg1").for(:password)}
    it {is_expected.to_not allow_value("abcde@1").for(:password)}
  end

  it "has a valid factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "can be created if username, email and password given" do
    user = FactoryBot.build(:user, username: nil)
    user.valid?
    expect(user.errors[:username]).to include("can't be blank")
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
    user = FactoryBot.build(:user)
    expect(user.valid?).to be_truthy
  end

  it "is invalid if username not unique" do
    FactoryBot.create(:user, username: "sulmanweb")
    user = FactoryBot.build(:user, username: "sulmanweb")
    user.valid?
    expect(user.errors[:username]).to include("has already been taken")
  end

  it "is invalid if email not unique" do
    FactoryBot.create(:user, email: "sulmanweb@gmail.com")
    user = FactoryBot.build(:user, email: "sulmanweb@gmail.com")
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

  it "is valid to edit without providing current password" do
    user = FactoryBot.create(:user)
    user.update(username: "sulmanweb")
    expect(user.valid?).to be_truthy
  end
end
