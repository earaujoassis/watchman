# frozen_string_literal: true

RSpec.describe Api::Controllers::Reports::Show, type: :action do
  it "should return Not Found when there's no server" do
    perform_request
    expect(status_code).to eq 404
  end
end
