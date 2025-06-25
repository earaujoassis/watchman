require 'rails_helper'

RSpec.describe ActionExecution, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:action) }
    it { should belong_to(:action) }
    it { should validate_presence_of(:identification) }
    it { should validate_presence_of(:type) }
    it { should validate_presence_of(:payload) }
    it { should validate_presence_of(:current_status) }
    it { should validate_presence_of(:status_reason) }
    it { should define_enum_for(:current_status)
         .with_values(pending: "pending", active: "active", completed: "completed", failed: "failed")
         .backed_by_column_of_type(:string)
         .with_prefix(true) }

    it 'rejects invalid JSON schema' do
      payload = Hash.new.to_json.to_s
      action = build(:action, payload: payload)
      expect(action.valid?).to be false
      expect(action.errors[:payload]).to include(/missing required field: managed_project/)
      expect(action.errors[:payload]).to include(/missing required field: managed_realm/)
      expect(action.errors[:payload]).to include(/missing required field: commit_hash/)
    end
  end

  it 'defaults to pending current_status' do
    execution = create(:action_execution)
    expect(execution.current_status_pending?).to be true
  end
end
