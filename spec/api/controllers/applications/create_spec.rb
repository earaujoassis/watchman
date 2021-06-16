# frozen_string_literal: true

RSpec.describe Api::Controllers::Applications::Create, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it "should return Bad Request when there's any missing attribute" do
    response = action.call(Hash.new)
    status_code = response[0]
    expect(status_code).to eq 400
  end
end
