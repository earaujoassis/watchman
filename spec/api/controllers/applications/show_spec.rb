# frozen_string_literal: true

RSpec.describe Api::Controllers::Applications::Show, type: :action do
  it "should return Not Found when there's no such application" do
    perform_request
    expect(status_code).to eq 404
  end
end
