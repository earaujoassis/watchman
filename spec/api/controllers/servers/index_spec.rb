# frozen_string_literal: true

RSpec.describe Api::Controllers::Servers::Index, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  before(:each) do
    clear_repositories
  end

  it "should retrieve an empty server list by default" do
    response = action.call(params)
    status_code = response[0]
    expect(status_code).to eq 200
    body = JSON.parse(response[2].first)
    expect(body["servers"]).to be_empty
  end

  it "should retrive a list with existing server" do
    ServerRepository.new.create({
      hostname: "testing.example.com",
      ip: "1.1.1.1",
      latest_version: "0.0.0"
    })
    response = action.call(params)
    status_code = response[0]
    expect(status_code).to eq 200
    body = JSON.parse(response[2].first)
    expect(body["servers"].first["hostname"]).to eq "testing.example.com"
    expect(body["servers"].first["ip"]).to eq "1.1.1.1"
    expect(body["servers"].first["latest_version"]).to eq "0.0.0"
  end
end
