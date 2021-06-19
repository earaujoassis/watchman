# frozen_string_literal: true

RSpec.describe Api::Controllers::Repositories::Index, type: :action do
  it "should return Not Found when there's no user" do
    perform_request
    expect(status_code).to eq 404
  end
end
