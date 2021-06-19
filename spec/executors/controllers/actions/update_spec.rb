# frozen_string_literal: true

RSpec.describe Executors::Controllers::Actions::Update, type: :action do
  let(:params) {
    {
      current_status: "finished",
      status_reason: "from testing context"
    }
  }
  let(:invalid_params) {
    {
      current_status: "invalid",
      status_reason: "from testing context"
    }
  }

  before(:each) do
    clear_repositories
  end

  it "should return Not Found when action doesn't exist" do
    perform_request_with_params({ id: "inexistent" })
    expect(status_code).to eq 404
    expect(body).to eq({ error: "unknown action" })
  end

  it "should return Unacceptable for invalid params" do
    action = fixture_generate_action
    perform_request_with_params({ id: action.uuid, action: invalid_params })
    expect(status_code).to eq 406
    expect(body).to eq({
      error: {
        message: "cannot update action",
        reasons: {
          current_status: "is not valid"
        }
      }
    })
  end

  it "should return updated action" do
    action = fixture_generate_action
    perform_request_with_params({ id: action.uuid, action: params })
    expect(status_code).to eq 200
    expect(body).to eq({
      action: {
        action_id: action.uuid,
        current_status: "finished",
        type: "git_ops_updater",
        managed_realm: "none",
        managed_project: "none",
        commit_hash: "320dj3e"
      }
    })
  end
end
