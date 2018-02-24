require 'rails_helper'

RSpec.describe Session, type: :model do
  it "has a valid factory" do
    session = FactoryBot.build(:session)
    expect(session.valid?).to be_truthy
  end

  it "generates last used at after create" do
    session = FactoryBot.create(:session)
    expect(session.last_used_at).to_not eql nil
  end

  it "must have a utoken" do
    session = FactoryBot.build(:session)
    session.valid?
    expect(session.utoken).to_not eql nil
    expect(session.utoken.length).to eql UTOKEN_LENGTH
  end

  it "meets the destroy dependendency" do
    session = FactoryBot.create(:session)
    User.find_by_id(session.user_id).destroy
    expect(Session.find_by_id(session.id)).to eql nil
  end

  it "must be active when created" do
    session = FactoryBot.create(:session)
    expect(session.active).to be_truthy
  end
end
