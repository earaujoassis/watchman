# frozen_string_literal: true

RSpec.describe Backdoor::Services::AgentAuthentication, type: :service do
  let(:service) { described_class.new }

  before(:all) do
    ENV.delete("WATCHMAN_DISABLE_AUTHENTICATION")
  end

  after(:all) do
    ENV["WATCHMAN_DISABLE_AUTHENTICATION"] ||= "yes"
  end

  before(:each) do
    clear_repositories
  end

  describe "#authentic_client?" do
    it "should authorize valid and active credential" do
      user = fixture_generate_user
      credential_command = Backdoor::Commands::CredentialCreateCommand.new(user: user)
      credential = credential_command.perform
      service = described_class.new({
        "HTTP_AUTHORIZATION" => authorization_code(credential_command.client_key, credential_command.client_secret)
      })
      expect(service.authentic_client?).to be true
    end

    it "should unauthorize invalid credential" do
      user = fixture_generate_user
      credential_command = Backdoor::Commands::CredentialCreateCommand.new(user: user)
      client_key, client_secret = credential_command.generate_credentials
      service = described_class.new({
        "HTTP_AUTHORIZATION" => authorization_code(client_key, client_secret)
      })
      expect(service.authentic_client?).to be false
    end

    it "should unauthorize inactive credential" do
      user = fixture_generate_user
      repository = CredentialRepository.new
      credential_command = Backdoor::Commands::CredentialCreateCommand.new(user: user)
      credential = credential_command.perform
      repository.inactivate(user, credential)
      service = described_class.new({
        "HTTP_AUTHORIZATION" => authorization_code(credential_command.client_key, credential_command.client_secret)
      })
      expect(service.authentic_client?).to be false
    end
  end

  describe "#retrieve_credential!" do
    it "should retrieve valid and active credential" do
      user = fixture_generate_user
      credential_command = Backdoor::Commands::CredentialCreateCommand.new(user: user)
      credential = credential_command.perform
      service = described_class.new({
        "HTTP_AUTHORIZATION" => authorization_code(credential_command.client_key, credential_command.client_secret)
      })
      expect(service.retrieve_credential!).to eq(credential)
    end

    it "should raise UndefinedEntity for invalid credential" do
      user = fixture_generate_user
      credential_command = Backdoor::Commands::CredentialCreateCommand.new(user: user)
      client_key, client_secret = credential_command.generate_credentials
      service = described_class.new({
        "HTTP_AUTHORIZATION" => authorization_code(client_key, client_secret)
      })
      expect { service.retrieve_credential! }.to raise_error(Backdoor::Errors::UndefinedEntity, "credential not found")
    end

    it "should raise UndefinedEntity for inactive credential" do
      user = fixture_generate_user
      repository = CredentialRepository.new
      credential_command = Backdoor::Commands::CredentialCreateCommand.new(user: user)
      credential = credential_command.perform
      repository.inactivate(user, credential)
      service = described_class.new({
        "HTTP_AUTHORIZATION" => authorization_code(credential_command.client_key, credential_command.client_secret)
      })
      expect { service.retrieve_credential! }.to raise_error(Backdoor::Errors::UndefinedEntity, "credential not found")
    end
  end
end
