# frozen_string_literal: true

RSpec.describe Api::Controllers::Credentials::Index, type: :action do
  let(:repository) { UserRepository.new }

  before(:each) do
    clear_repositories
  end

  it "should return Bad Request when missing any required param" do
    perform_request
    expect(status_code).to eq 400
  end

  it "should return Not Found when there's no user" do
    perform_request_with_params({ id: "inexistent" })
    expect(status_code).to eq 404
  end

  it "should return empty credentials list when user has no credential" do
    user = fixture_generate_user
    perform_request_with_params({ id: user.uuid })
    expect(status_code).to eq 200
    expect(body).to eq({ user: { credentials: [] } })
  end

  it "should return a CSV file with the credentials" do
    user = fixture_generate_user
    credential = repository.add_credential(user)
    perform_request_with_params({ id: user.uuid })
    expect(status_code).to eq 200
    expect(body[:user][:credentials].first[:id]).to eq credential.uuid
  end
end
