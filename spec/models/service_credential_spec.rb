require 'rails_helper'

RSpec.describe ServiceCredential, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:user) }
    it { should belong_to(:user) }
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:client_key) }
    it { should validate_presence_of(:client_secret) }
  end

  describe '#active?' do
    it 'returns true when user is active' do
      service_credential = create(:service_credential, active: true)
      expect(service_credential.active?).to be true
    end
  end
end
