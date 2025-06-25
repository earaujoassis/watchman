require 'rails_helper'

RSpec.describe Action, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:artifact) }
    it { should belong_to(:artifact) }
    it { should validate_presence_of(:identification) }
    it { should validate_presence_of(:type) }
    it { should validate_presence_of(:payload) }

    it 'rejects invalid JSON schema' do
      payload = Hash.new.to_json.to_s
      action = build(:action, payload: payload)
      expect(action.valid?).to be false
      expect(action.errors[:payload]).to include(/missing required field: managed_project/)
      expect(action.errors[:payload]).to include(/missing required field: managed_realm/)
      expect(action.errors[:payload]).to include(/missing required field: commit_hash/)
    end
  end

  describe '#active?' do
    it 'returns true when user is active' do
      action = create(:action, active: true)
      expect(action.active?).to be true
    end
  end
end
