# frozen_string_literal: true

RSpec.describe Api::Controllers::Credentials::Create, type: :action do
  before(:each) do
    clear_repositories
  end

  it "should return Not Found when there's no user" do
    perform_request
    expect(status_code).to eq 404
  end

  it "should return Not Found when id is wrong" do
    user = UserRepository.new.create_master_user({
      email: "john.doe@example.com",
      passphrase: "testingpassword",
      github_token: "testingtoken"
    })
    perform_request_with_params({ id: "inexistent" })
    expect(status_code).to eq 404
  end

  it "should return a CSV file with the credentials" do
    user = UserRepository.new.create_master_user({
      email: "john.doe@example.com",
      passphrase: "testingpassword",
      github_token: "testingtoken"
    })
    perform_request_with_params({ id: user.uuid })
    expect(status_code).to eq 200
    expect(headers["Content-Type"]).to eq "text/csv"
    expect(headers["Content-Disposition"]).to eq 'attachment; filename="credentials.csv"'
  end
end
