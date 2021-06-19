# frozen_string_literal: true

RSpec.describe Executors::Controllers::Actions::Index, type: :action do
  before(:each) do
    clear_repositories
  end

  it "should return empty list when there's no pending actions" do
    perform_request
    expect(status_code).to eq 200
    expect(body).to eq({ actions: [] })
  end

  it "should return pending actions for active applications" do
    action = fixture_generate_action
    perform_request
    expect(status_code).to eq 200
    expect(body).to eq({
      actions: [
        {
          action_id: action.uuid,
          current_status: "created",
          type: "git_ops_updater",
          application: "testing/application",
          managed_realm: "none",
          managed_project: "none",
          commit_hash: "320dj3e"
        }
      ]
    })
  end
end
