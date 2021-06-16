# frozen_string_literal: true

RSpec.describe Api::Controllers::Users::Index, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  before(:each) do
    clear_repositories
  end

  it "should return nil when no user is available" do
    response = action.call(params)
    status_code = response[0]
    expect(status_code).to eq 200
    body = JSON.parse(response[2].first)
    expect(body["user"]).to be_nil
  end

  it "should the user if it already exists" do
    UserRepository.new.create_master_user({
      email: "john.doe@example.com",
      passphrase: "testingpassword",
      github_token: "testingtoken"
    })
    response = action.call(params)
    status_code = response[0]
    expect(status_code).to eq 200
    body = JSON.parse(response[2].first)
    expect(body["user"]["email"]).to eq "john.doe@example.com"
    expect(body["user"]["github_token"]).to eq "******gtoken"
  end
end
