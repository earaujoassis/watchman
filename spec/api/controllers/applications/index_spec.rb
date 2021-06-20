# frozen_string_literal: true

RSpec.describe Api::Controllers::Applications::Index, type: :action do
  before(:each) do
    clear_repositories
  end

  it "should return Bad Request when missing any required param" do
    perform_request
    expect(status_code).to eq 400
  end

  it "should return an empty list when there's no application for user" do
    user = fixture_generate_user
    perform_request_with_params({ id: user.uuid })
    expect(status_code).to eq 200
    expect(body[:user][:applications]).to be_empty
  end
end
