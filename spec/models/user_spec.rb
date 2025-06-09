# == Schema Information
#
# Table name: users
#
#  id          :uuid             not null, primary key
#  sequence_id :integer          not null
#  public_id   :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  active      :boolean
#
# Indexes
#
#  index_users_on_public_id    (public_id) UNIQUE
#  index_users_on_sequence_id  (sequence_id) UNIQUE
#

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:public_id) }
  end

  describe '#active?' do
    it 'returns true when user is active' do
      user = create(:user, active: true)
      expect(user.active?).to be true
    end
  end
end
