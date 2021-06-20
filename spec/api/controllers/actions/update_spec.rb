# frozen_string_literal: true

RSpec.describe Api::Controllers::Actions::Update, type: :action do
  it "should return Bad Request when missing any required param" do
    perform_request
    expect(status_code).to eq 400
  end
end
