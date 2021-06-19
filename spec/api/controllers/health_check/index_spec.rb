# frozen_string_literal: true

RSpec.describe Api::Controllers::HealthCheck::Index, type: :action do
  it "should return Ok when database connection is working" do
    perform_request
    expect(status_code).to eq 200
    expect(body).to eq({ message: "healthy" })
  end
end
