require 'rails_helper'

RSpec.describe GitCredential, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:user) }
    it { should belong_to(:user) }
    it { should validate_presence_of(:identification) }
    it { should validate_presence_of(:committer_identification) }
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password) }
  end

  describe '#active?' do
    it 'returns true when user is active' do
      git_credential = create(:git_credential, active: true)
      expect(git_credential.active?).to be true
    end
  end
end
