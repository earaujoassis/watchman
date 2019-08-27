RSpec.describe Api::Controllers::Server::ReportList, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it "should return Not Found when there's no server" do
    response = action.call(Hash.new)
    status_code = response[0]
    expect(status_code).to eq 404
  end
end
