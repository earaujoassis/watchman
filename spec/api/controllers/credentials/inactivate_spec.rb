# frozen_string_literal: true

RSpec.describe Api::Controllers::Credentials::Inactivate, type: :action do
  before(:each) do
    clear_repositories
  end

  it "should return Bad Request when missing any required param" do
    perform_request
    expect(status_code).to eq 400
  end

  it "should return Not Found when there's no user for given :user_id" do
    perform_request_with_params({ user_id: "inexistent", credential_id: "inexistent" })
    expect(status_code).to eq 404
    expect(body).to eq({ error: "user not found" })
  end

  it "should return Not Found when there's no credential for given :credential_id" do
    user = fixture_generate_user
    perform_request_with_params({ user_id: user.uuid, credential_id: "inexistent" })
    expect(status_code).to eq 404
    expect(body).to eq({ error: "credential not found" })
  end

  it "should return a CSV file with the credentials" do
    user = fixture_generate_user
    credential_command = Backdoor::Commands::CredentialCreateCommand.new(user: user)
    credential = credential_command.perform
    perform_request_with_params({ user_id: user.uuid, credential_id: credential.uuid })
    expect(status_code).to eq 200
  end
end
