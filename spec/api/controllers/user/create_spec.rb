# frozen_string_literal: true

RSpec.describe Api::Controllers::Users::Create, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[user: { email: "john.doe@example.com", passphrase: "testingpassword", github_token: "testingtoken" }] }

  before(:each) do
    clear_repositories
  end

  it "should return Bad Request when there's any missing attribute" do
    response = action.call(Hash.new)
    status_code = response[0]
    expect(status_code).to eq 400
  end

  it "should create a new master user" do
    response = action.call(params)
    status_code = response[0]
    expect(status_code).to eq 200
    body = JSON.parse(response[2].first)
    expect(body["user"]["email"]).to eq "john.doe@example.com"
    expect(body["user"]["github_token"]).to eq "******gtoken"
  end
end
