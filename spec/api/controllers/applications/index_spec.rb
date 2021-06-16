# frozen_string_literal: true

RSpec.describe Api::Controllers::Applications::Index, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  before(:each) do
    clear_repositories
  end

  it "should return Not Found when there's no user" do
    response = action.call(Hash.new)
    status_code = response[0]
    expect(status_code).to eq 404
  end

  it "should return an empty list when there's not application for user" do
    user = UserRepository.new.create_master_user({
      email: "john.doe@example.com",
      passphrase: "testingpassword",
      github_token: "testingtoken"
    })
    response = action.call(Hash[id: user.uuid])
    status_code = response[0]
    expect(status_code).to eq 200
    body = JSON.parse(response[2].first)
    expect(body["user"]["applications"]).to be_empty
  end
end
