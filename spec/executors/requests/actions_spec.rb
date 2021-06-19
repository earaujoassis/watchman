# frozen_string_literal: true

RSpec.describe "Requests: /api/executors/actions", type: :requests do
  let(:app) { Hanami.app }

  before(:each) do
    clear_repositories
  end

  it "GET /api/executors/actions => Ok: { actions: [] }" do
    get "/api/executors/actions"

    expect(last_response.status).to be(200)
    expect(last_response.body).to eq(JSON.generate({ actions: [] }))
  end

  it "GET /api/executors/actions/:id => Ok: { action: <entity> }" do
    action = fixture_generate_action

    get "/api/executors/actions/#{action.uuid}"

    expect(last_response.status).to be(200)
    expect(last_response.body).to eq(JSON.generate({
      action: {
        managed_realm: "none",
        managed_project: "none",
        commit_hash: "320dj3e",
        action_id: action.uuid,
        current_status: "created",
        type: "git_ops_updater"
      }
    }))
  end

  it "PUT /api/executors/actions/:id => Ok: { action: <entity> }" do
    action = fixture_generate_action

    put "/api/executors/actions/#{action.uuid}", {
      action: {
        current_status: "finished",
        status_reason: "from testing context"
      }
    }

    expect(last_response.status).to be(200)
    expect(last_response.body).to eq(JSON.generate({
      action: {
        managed_realm: "none",
        managed_project: "none",
        commit_hash: "320dj3e",
        action_id: action.uuid,
        current_status: "finished",
        type: "git_ops_updater"
      }
    }))
  end
end
