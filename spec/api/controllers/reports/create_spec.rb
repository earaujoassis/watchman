# frozen_string_literal: true

RSpec.describe Api::Controllers::Reports::Create, type: :action do
  let(:action) { described_class.new }
  let(:params) do
    Hash[
      server: {
        hostname: "testing.example.com",
        ip: "1.1.1.1",
        latest_version: "0.0.0"
      },
      report: {
        subject: "Testing report"
      }
    ]
  end

  before(:each) do
    clear_repositories
  end

  it "should return Bad Request when there's any missing attribute" do
    response = action.call(Hash.new)
    status_code = response[0]
    expect(status_code).to eq 400
  end

  it "should create a server and a report for it" do
    response = action.call(params)
    status_code = response[0]
    expect(status_code).to eq 201
    body = JSON.parse(response[2].first)
    expect(body["report"]["id"]).not_to be_empty
  end

  it "should create a report for an existing server" do
    server = ServerRepository.new.create({
      hostname: "testing.example.com",
      ip: "1.1.1.1",
      latest_version: "0.0.0"
    })
    response = action.call(Hash[
      server: {
        hostname: "testing.example.com",
        ip: "1.1.1.1",
        latest_version: "0.1.0"
      },
      report: {
        subject: "Testing report"
      }
    ])
    status_code = response[0]
    expect(status_code).to eq 201
    body = JSON.parse(response[2].first)
    expect(body["report"]["id"]).not_to be_empty
  end
end
