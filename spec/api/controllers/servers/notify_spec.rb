# frozen_string_literal: true

RSpec.describe Api::Controllers::Servers::Notify, type: :action do
  let(:github_response) do
    '[
      {
        "name": "v0.2.4",
        "commit": {
          "sha": "f5f421621a700ee6f3e816a0a81fa85eab9d5f1a",
          "url": "https://api.github.com/repos/earaujoassis/watchman/commits/f5f421621a700ee6f3e816a0a81fa85eab9d5f1a"
        },
        "zipball_url": "https://github.com/earaujoassis/watchman/zipball/v0.2.4",
        "tarball_url": "https://github.com/earaujoassis/watchman/tarball/v0.2.4",
        "node_id": "MDQ6VXNlcjE="
      }
    ]'
  end

  before(:each) do
    clear_repositories
  end

  it "should return Bad Request when there's any missing attribute" do
    perform_request
    expect(status_code).to eq 400
  end

  it "should notify about a remote server" do
    stub_request(:get, "https://api.github.com/repos/earaujoassis/watchman/tags")
      .with(
        headers: {
          "Accept" => "application/vnd.github.v3+json",
          "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
          "Content-Type" => "application/json"
      })
      .to_return(status: 200, body: github_response, headers: { "Content-Type" => "application/json" })
    perform_request_with_params({
      server: {
        hostname: "testing.example.com",
        ip: "1.1.1.1",
        latest_version: "0.0.0"
      }
    })
    expect(status_code).to eq 200
    expect(body[:version]).to eq Backdoor::VERSION
    expect(body[:server][:hostname]).to eq "testing.example.com"
    expect(body[:server][:ip]).to eq "1.1.1.1"
    expect(body[:server][:latest_version]).to eq "0.0.0"
  end

  it "should notify and update an existing server" do
    stub_request(:get, "https://api.github.com/repos/earaujoassis/watchman/tags")
      .with(
        headers: {
          "Accept" => "application/vnd.github.v3+json",
          "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
          "Content-Type" => "application/json"
      })
      .to_return(status: 200, body: github_response, headers: { "Content-Type" => "application/json" })
    server = ServerRepository.new.create({
      hostname: "testing.example.com",
      ip: "1.1.1.1",
      latest_version: "0.0.0"
    })
    perform_request_with_params({
      server: {
        hostname: "testing.example.com",
        ip: "2.2.2.2",
        latest_version: "0.1.0"
      }
    })
    expect(status_code).to eq 200
    expect(body[:version]).to eq Backdoor::VERSION
    expect(body[:server][:id]).to eq server.uuid
    expect(body[:server][:hostname]).to eq "testing.example.com"
    expect(body[:server][:ip]).to eq "2.2.2.2"
    expect(body[:server][:latest_version]).to eq "0.1.0"
  end
end
