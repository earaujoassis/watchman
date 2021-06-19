# frozen_string_literal: true

RSpec.describe Api::Controllers::Applications::Index, type: :action do
  before(:each) do
    clear_repositories
  end

  it "should return Not Found when there's no user" do
    perform_request
    expect(status_code).to eq 404
  end

  it "should return an empty list when there's not application for user" do
    user = UserRepository.new.create_master_user({
      email: "john.doe@example.com",
      passphrase: "testingpassword",
      github_token: "testingtoken"
    })
    perform_request_with_params({ id: user.uuid })
    expect(status_code).to eq 200
    expect(body[:user][:applications]).to be_empty
  end
end
