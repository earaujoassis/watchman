RSpec.describe Api::Controllers::User::Update, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it "should return Bad Request when there's any missing attribute" do
    response = action.call(params)
    status_code = response[0]
    expect(status_code).to eq 400
  end
end
