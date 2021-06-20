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
    fixture_generate_user
    perform_request
    expect(status_code).to eq 200
    expect(body[:user][:email]).to eq "john.doe@example.com"
    expect(body[:user][:github_token]).to eq "******g_token"
  end
end
