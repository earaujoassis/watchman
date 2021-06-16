# frozen_string_literal: true

RSpec.describe Api::Controllers::Credentials::Create, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  before(:each) do
    clear_repositories
  end

  it "should return Not Found when there's no user" do
    response = action.call(params)
    status_code = response[0]
    expect(status_code).to eq 404
  end

  it "should return a CSV file with the credentials" do
    user = UserRepository.new.create_master_user({
      email: "john.doe@example.com",
      passphrase: "testingpassword",
      github_token: "testingtoken"
    })
    response = action.call(Hash[id: user.uuid])
    status_code = response[0]
    expect(status_code).to eq 200
    header = response[1]
    expect(header["Content-Type"]).to eq "text/csv"
    expect(header["Content-Disposition"]).to eq 'attachment; filename="credentials.csv"'
  end
end
