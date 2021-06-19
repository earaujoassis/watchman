# frozen_string_literal: true

RSpec.describe Api::Controllers::Users::Index, type: :action do
  before(:each) do
    clear_repositories
  end

  it "should return nil when no user is available" do
    perform_request
    expect(status_code).to eq 200
    expect(body).to eq({ user: nil })
  end

  it "should the user if it already exists" do
    UserRepository.new.create_master_user({
      email: "john.doe@example.com",
      passphrase: "testingpassword",
      github_token: "testingtoken"
    })
    perform_request
    expect(status_code).to eq 200
    expect(body[:user][:email]).to eq "john.doe@example.com"
    expect(body[:user][:github_token]).to eq "******gtoken"
  end
end
