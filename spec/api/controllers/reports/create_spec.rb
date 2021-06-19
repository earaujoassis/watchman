# frozen_string_literal: true

RSpec.describe Api::Controllers::Reports::Create, type: :action do
  before(:each) do
    clear_repositories
  end

  it "should return Bad Request when there's any missing attribute" do
    perform_request
    expect(status_code).to eq 400
  end

  it "should create a server and a report for it" do
    perform_request_with_params({
      server: {
        hostname: "testing.example.com",
        ip: "1.1.1.1",
        latest_version: "0.0.0"
      },
      report: {
        subject: "Testing report"
      }
    })
    expect(status_code).to eq 200
    expect(body[:report][:id]).not_to be_empty
  end

  it "should create a report for an existing server" do
    server = ServerRepository.new.create({
      hostname: "testing.example.com",
      ip: "1.1.1.1",
      latest_version: "0.0.0"
    })
    perform_request_with_params({
      server: {
        hostname: "testing.example.com",
        ip: "1.1.1.1",
        latest_version: "0.1.0"
      },
      report: {
        subject: "Testing report"
      }
    })
    expect(status_code).to eq 200
    expect(body[:report][:id]).not_to be_empty
  end
end
