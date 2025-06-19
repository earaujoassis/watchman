require 'rails_helper'

RSpec.describe Artifact, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:user) }
    it { should belong_to(:user) }
    it { should validate_presence_of(:full_name) }
  end

  describe '#active?' do
    it 'returns true when user is active' do
      artifact = create(:artifact, active: true)
      expect(artifact.active?).to be true
    end
  end
end
