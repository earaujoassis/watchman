# frozen_string_literal: true

require "bcrypt"
require "securerandom"

class Backdoor::Commands::CredentialCreateCommand < Backdoor::Commands::BaseCommand
  attr_reader :client_key
  attr_reader :client_secret

  def initialize(params: Hash.new, user:)
    super(params: params)
    @valid = true
    @client_key = nil
    @client_secret = nil
    @user = user
  end

  def perform
    validate
    raise Backdoor::Errors::CommandError.new("cannot create credential", @errors) unless valid?
    @client_key, @client_secret = generate_credentials
    repository = UserRepository.new
    data = {
      description: @params[:description],
      client_key: @client_key,
      client_secret: @client_secret
    }
    repository.add_credential(@user, data)
  end

  def generate_credentials
    [
      "W#{SecureRandom.hex(Credential::CLIENT_KEY_LENGTH)}"[0..31].upcase,
      SecureRandom.hex(Credential::CLIENT_SECRET_LENGTH)
    ]
  end

  def validate
    validator(validate_description, :description, "is not valid")
  end

  private

  def validate_description
    unless @params[:description].nil?
      @params[:description].length > 1 && @params[:description].length <= 20
    else
      true
    end
  end
end
