# frozen_string_literal: true

RSpec.describe Executors::Controllers::Actions::Show, type: :action do
  before(:each) do
    clear_repositories
  end

  it "should return Not Found when action doesn't exist" do
    perform_request_with_params({ id: "inexistent" })
    expect(status_code).to eq 404
    expect(body).to eq({ error: "unknown action" })
  end

  it "should return requested action" do
    action = fixture_generate_action
    perform_request_with_params({ id: action.uuid })
    expect(status_code).to eq 200
    expect(body).to eq({
      action: {
        action_id: action.uuid,
        current_status: "created",
        type: "git_ops_updater",
        managed_realm: "none",
        managed_project: "none",
        commit_hash: "320dj3e"
      }
    })
  end
end
