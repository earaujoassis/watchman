# frozen_string_literal: true

RSpec.describe Api::Controllers::Credentials::Inactivate, type: :action do
  let(:repository) { UserRepository.new }

  before(:each) do
    clear_repositories
  end

  it "should return Bad Request when missing any required param" do
    perform_request
    expect(status_code).to eq 400
  end

  it "should return Not Found when there's no credential for given :credential_id" do
    user = fixture_generate_user
    perform_request_with_params({ user_id: user.uuid, credential_id: "inexistent" })
    expect(status_code).to eq 404
    expect(body).to eq({ error: "unknown credential" })
  end

  it "should return a CSV file with the credentials" do
    user = fixture_generate_user
    credential = repository.add_credential(user)
    perform_request_with_params({ user_id: user.uuid, credential_id: credential.uuid })
    expect(status_code).to eq 200
  end
end
