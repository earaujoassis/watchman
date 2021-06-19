# frozen_string_literal: true

require "spec_helper"

describe Watchman::Health do
  context "verify_uri" do
    it "should return the elapsed_time and status_code" do
      stub_request(:head, "https://github.com/")
        .with(
          headers: {
            "Accept"=>"*/*",
            "User-Agent"=>"Ruby"
          })
        .to_return(status: 200, body: "", headers: {})
      response = Watchman::Health.verify_uri("https://github.com")
      expect(response[:elapsed_time].to_i).to be <= 5 # seconds
      expect(response[:status_code]).to eq 200
    end

    it "should return the elapsed_time and status_code" do
      stub_request(:head, "https://www.facebook.com/")
        .with(
          headers: {
            "Accept"=>"*/*",
            "User-Agent"=>"Ruby"
          })
        .to_return(status: 200, body: "", headers: {})
      response = Watchman::Health.verify_uri("https://www.facebook.com")
      expect(response[:elapsed_time].to_i).to be <= 5 # seconds
      expect(response[:status_code]).to eq 200
    end
  end
end
