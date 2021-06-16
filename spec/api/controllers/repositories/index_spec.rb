# frozen_string_literal: true

RSpec.describe Api::Controllers::Repositories::Index, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it "should return Not Found when there's no user" do
    response = action.call(params)
    status_code = response[0]
    expect(status_code).to eq 404
  end
end
