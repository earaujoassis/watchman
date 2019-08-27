require "spec_helper"

describe Watchman::Health do
  context "verify_uri" do
    it "should return the elapsed_time and status_code" do
      response = Watchman::Health.verify_uri("http://github.com")
      expect(response[:elapsed_time].to_i).to be <= 2 # 2 seconds
      expect(response[:status_code]).to eq 200
    end

    it "should return the elapsed_time and status_code" do
      response = Watchman::Health.verify_uri("https://www.facebook.com")
      expect(response[:elapsed_time].to_i).to be <= 2 # 2 seconds
      expect(response[:status_code]).to eq 200
    end
  end
end
