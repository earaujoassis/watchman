# frozen_string_literal: true

RSpec.describe Api::Controllers::Credentials::Create, type: :action do
  before(:each) do
    clear_repositories
  end

  it "should return Bad Request when missing any required param" do
    perform_request
    expect(status_code).to eq 400
    expect(body).to eq({
      error: {
        id: ["is missing"],
        user: ["is missing"]
      }
    })
  end

  it "should return Not Found when id is wrong" do
    user = fixture_generate_user
    perform_request_with_params({
      id: "inexistent",
      user: {
        passphrase_confirmation: "incorrect"
      }
    })
    expect(status_code).to eq 404
    expect(body).to eq({ error: "user not found" })
  end

  it "should return Unauthorized when user's passphrase is wrong" do
    user = fixture_generate_user
    perform_request_with_params({
      id: user.uuid,
      user: {
        passphrase_confirmation: "incorrect"
      }
    })
    expect(status_code).to eq 401
    expect(body).to eq({ error: "wrong passphrase" })
  end

  it "should return a CSV file with the credentials" do
    user = fixture_generate_user
    perform_request_with_params({
      id: user.uuid,
      user: {
        passphrase_confirmation: "testing_passphrase"
      }
    })
    expect(status_code).to eq 200
    expect(headers["Content-Type"]).to eq "text/csv"
    expect(headers["Content-Disposition"]).to eq 'attachment; filename="credentials.csv"'
  end

  it "should accept credential's description and return a CSV file with the credentials" do
    user = fixture_generate_user
    perform_request_with_params({
      id: user.uuid,
      credential: {
        description: "testing"
      },
      user: {
        passphrase_confirmation: "testing_passphrase"
      }
    })
    expect(status_code).to eq 200
    expect(headers["Content-Type"]).to eq "text/csv"
    expect(headers["Content-Disposition"]).to eq 'attachment; filename="credentials.csv"'
  end
end
