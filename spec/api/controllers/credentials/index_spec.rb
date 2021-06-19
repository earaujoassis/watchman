# frozen_string_literal: true

RSpec.describe Api::Controllers::Credentials::Index, type: :action do
  let(:repository) { UserRepository.new }

  before(:each) do
    clear_repositories
  end

  it "should return Not Found when there's no user" do
    perform_request
    expect(status_code).to eq 404
    perform_request_with_params({ id: "inexistent" })
    expect(status_code).to eq 404
  end

  it "should return empty credentials list when user has no credential" do
    user = repository.create_master_user({
      email: "john.doe@example.com",
      passphrase: "testingpassword",
      github_token: "testingtoken"
    })
    perform_request_with_params({ id: user.uuid })
    expect(status_code).to eq 200
    expect(body).to eq({ user: { credentials: [] } })
  end

  it "should return a CSV file with the credentials" do
    user = repository.create_master_user({
      email: "john.doe@example.com",
      passphrase: "testingpassword",
      github_token: "testingtoken"
    })
    credential = repository.add_credential(user)
    perform_request_with_params({ id: user.uuid })
    expect(status_code).to eq 200
    expect(body[:user][:credentials].first[:id]).to eq credential.uuid
  end
end
