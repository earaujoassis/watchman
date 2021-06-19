# frozen_string_literal: true

RSpec.describe Api::Controllers::Applications::Create, type: :action do
  it "should return Bad Request when there's any missing attribute" do
    perform_request
    expect(status_code).to eq 400
  end
end
