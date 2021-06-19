# frozen_string_literal: true

RSpec.describe Api::Controllers::Credentials::Inactivate, type: :action do
  let(:repository) { UserRepository.new }

  before(:each) do
    clear_repositories
  end

  it "should return Not Found when there's no user" do
    perform_request
    expect(status_code).to eq 404
    expect(body).to eq({ error: "unknown user" })
  end

  it "should return Not Found when there's no credential for given :id" do
    user = repository.create_master_user({
      email: "john.doe@example.com",
      passphrase: "testingpassword",
      github_token: "testingtoken"
    })
    perform_request_with_params({ user_id: user.uuid, credential_id: "inexistent" })
    expect(status_code).to eq 404
    expect(body).to eq({ error: "unknown credential" })
  end

  it "should return a CSV file with the credentials" do
    user = repository.create_master_user({
      email: "john.doe@example.com",
      passphrase: "testingpassword",
      github_token: "testingtoken"
    })
    credential = repository.add_credential(user)
    perform_request_with_params({ user_id: user.uuid, credential_id: credential.uuid })
    expect(status_code).to eq 200
  end
end
