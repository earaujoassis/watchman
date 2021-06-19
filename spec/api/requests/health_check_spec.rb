# frozen_string_literal: true

RSpec.describe "Requests: /api/health-check", type: :requests do
  let(:app) { Hanami.app }

  before(:each) do
    clear_repositories
  end

  it 'GET /api/health-check => Ok: { message: "healthy" }' do
    get "/api/health-check"

    expect(last_response.status).to be(200)
    expect(last_response.body).to eq(JSON.generate({ message: "healthy" }))
  end
end
