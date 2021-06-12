RSpec.describe Api::Controllers::Server::Notify, type: :action do
  let(:action) { described_class.new }
  let(:params) do
    Hash[server: {
      hostname: "testing.example.com",
      ip: "1.1.1.1",
      latest_version: "0.0.0"
    }]
  end

  before(:each) do
    ReportRepository.new.clear
    ServerRepository.new.clear
  end

  it "should return Bad Request when there's any missing attribute" do
    response = action.call(Hash.new)
    status_code = response[0]
    expect(status_code).to eq 400
  end

  it "should notify about a remote server" do
    response = action.call(params)
    status_code = response[0]
    expect(status_code).to eq 201
    body = JSON.parse(response[2].first)
    expect(body["version"]).to eq Backdoor::VERSION
    expect(body["server"]["hostname"]).to eq "testing.example.com"
    expect(body["server"]["ip"]).to eq "1.1.1.1"
    expect(body["server"]["latest_version"]).to eq "0.0.0"
  end

  it "should notify and update an existing server" do
    server = ServerRepository.new.create({
      hostname: "testing.example.com",
      ip: "1.1.1.1",
      latest_version: "0.0.0"
    })
    response = action.call(Hash[server: {
      hostname: "testing.example.com",
      ip: "2.2.2.2",
      latest_version: "0.1.0"
    }])
    status_code = response[0]
    expect(status_code).to eq 201
    body = JSON.parse(response[2].first)
    expect(body["version"]).to eq Backdoor::VERSION
    expect(body["server"]["id"]).to eq server.uuid
    expect(body["server"]["hostname"]).to eq "testing.example.com"
    expect(body["server"]["ip"]).to eq "2.2.2.2"
    expect(body["server"]["latest_version"]).to eq "0.1.0"
  end
end
