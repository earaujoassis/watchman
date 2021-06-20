# frozen_string_literal: true

RSpec.describe Api::Controllers::Reports::Create, type: :action do
  before(:each) do
    clear_repositories
  end

  it "should return Bad Request when missing any required param" do
    perform_request
    expect(status_code).to eq 400
  end

  it "should create a server and a report for it" do
    expect(ServerRepository.new.all.length).to eq 0
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
    expect(ServerRepository.new.all.length).to eq 1
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
    expect(ServerRepository.new.all.length).to eq 1
  end
end
