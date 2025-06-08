FactoryBot.define do
  factory :action do
    sequence_id { 1 }
    association :artifact
    active { true }
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
  end
end
