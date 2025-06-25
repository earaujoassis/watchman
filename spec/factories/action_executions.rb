FactoryBot.define do
  factory :action_execution do
    sequence_id { 1 }
    association :action
    identification { Faker::Internet.slug }
    type { 'artifact_update' }
    payload {
      {
        description: 'Update artifact in GitOps operations',
        managed_project: 'project_name',
        managed_realm: 'managed_realm',
        commit_hash: 'commit_hash'
      }.to_json.to_s
    }
    status_reason { 'created on database' }
  end
end
