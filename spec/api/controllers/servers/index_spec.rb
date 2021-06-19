# frozen_string_literal: true

RSpec.describe Api::Controllers::Servers::Index, type: :action do
  before(:each) do
    clear_repositories
  end

  it "should retrieve an empty server list by default" do
    perform_request
    expect(status_code).to eq 200
    expect(body[:servers]).to be_empty
  end

  it "should retrive a list with existing server" do
    ServerRepository.new.create({
      hostname: "testing.example.com",
      ip: "1.1.1.1",
      latest_version: "0.0.0"
    })
    perform_request
    expect(status_code).to eq 200
    expect(body[:servers].first[:hostname]).to eq "testing.example.com"
    expect(body[:servers].first[:ip]).to eq "1.1.1.1"
    expect(body[:servers].first[:latest_version]).to eq "0.0.0"
  end
end
