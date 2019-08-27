RSpec.describe Api::Controllers::Applications::View, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it "should return Not Found when there's no such application" do
    response = action.call(Hash.new)
    status_code = response[0]
    expect(status_code).to eq 404
  end
end
