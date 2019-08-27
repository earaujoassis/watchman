RSpec.describe Api::Controllers::User::AppList, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  before(:each) do
    ActionRepository.new.clear
    ApplicationRepository.new.clear
    UserRepository.new.clear
  end

  it "should return Not Found when there's no user" do
    response = action.call(Hash.new)
    status_code = response[0]
    expect(status_code).to eq 404
  end

  it "should return an empty list when there's not application for user" do
    user = UserRepository.new.create_master_user({
      email: 'john.doe@example.com',
      github_token: 'testingtoken'
    })
    response = action.call(Hash[id: user.uuid])
    status_code = response[0]
    expect(status_code).to eq 200
    body = JSON.parse(response[2].first)
    expect(body['user']['apps']).to be_empty
  end
end
