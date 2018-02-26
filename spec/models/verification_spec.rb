require 'rails_helper'

RSpec.describe Verification, type: :model do
  describe "#v_type" do
    it {is_expected.to validate_presence_of(:v_type)}
    it {is_expected.to allow_value(:confirm).for(:v_type)}
    it {is_expected.to allow_value(:reset_password).for(:v_type)}
    it {is_expected.to define_enum_for(:v_type).with([:confirm, :reset_password])}
  end
  describe "#status" do
    it {is_expected.to validate_presence_of(:status)}
    it {is_expected.to allow_value(:pending).for(:status)}
    it {is_expected.to allow_value(:approved).for(:status)}
    it {is_expected.to allow_value(:late).for(:status)}
    it {is_expected.to define_enum_for(:status).with([:pending, :approved, :late])}
  end

  it "has a valid factory" do
    verification = FactoryBot.build(:verification)
    expect(verification.valid?).to be_truthy
  end

  it "has valid function build_confirm" do
    user = FactoryBot.create(:user)
    v = Verification.build_confirm(user)
    expect(v.valid?).to be_truthy
    expect(v.v_type).to eql 'confirm'
    expect(v.status).to eql 'pending'
  end

  it "has valid function build_reset" do
    user = FactoryBot.create(:user)
    v = Verification.build_reset(user)
    expect(v.valid?).to be_truthy
    expect(v.v_type).to eql 'reset_password'
    expect(v.status).to eql 'pending'
  end

  describe "#search_token" do

    include ActiveSupport::Testing::TimeHelpers
    it "gives nil if late" do
      v = FactoryBot.create(:verification)
      travel (CONFIRMATION_TIME_MAX+1).days
      x = Verification.search_token(v.token, 'confirm')
      expect(x.nil?).to be_truthy
      expect(Verification.find_by_token(v.token).status).to eql "late"
      travel_back
      v = FactoryBot.create(:verification, v_type: 'reset_password')
      travel (RESET_TIME_MAX+1).hours
      x = Verification.search_token(v.token, 'reset_password')
      expect(x.nil?).to be_truthy
      expect(Verification.find_by_token(v.token).status).to eql "late"
      travel_back
    end

    it "gives nil if not found" do
      v = FactoryBot.create(:verification)
      x = Verification.search_token("abcdefghijk", 'confirm')
      expect(x.nil?).to be_truthy
    end

    it "gives object if verified in time" do
      v = FactoryBot.create(:verification)
      travel (CONFIRMATION_TIME_MAX-1).days
      x = Verification.search_token(v.token, 'confirm')
      expect(x.nil?).to be_falsey
      expect(x.status).to eql "approved"
      travel_back
    end
  end
end
