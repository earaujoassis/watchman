# frozen_string_literal: true

RSpec.describe Backdoor::Services::Security, type: :service do
  let(:encryptor) { described_class.new }

  it "should encrypt and decrypt data if all information necessary is available" do
    plain_message = "Secret message to encrypt"

    encryptor.key = "OLVZV7gh14iAs571ru7HUVvJjnjgAnvDwCHUXLJNyY3kvZmFfm0jSXtxQxkD45jY"
    encryptor.version = "XCwp5vjL6u5C6KOy"
    expect(encryptor.key).to eq("OLVZV7gh14iAs571ru7HUVvJjnjgAnvDwCHUXLJNyY3kvZmFfm0jSXtxQxkD45jY")
    expect(encryptor.version).to eq("XCwp5vjL6u5C6KOy")

    encrypted_message = encryptor.encrypt(plain_message)
    expect(encrypted_message).not_to eq(plain_message)
    expect(encrypted_message).to start_with("XCwp5vjL6u5C6KOy")

    once_again_plain_message = encryptor.decrypt(encrypted_message)
    expect(once_again_plain_message).not_to start_with("XCwp5vjL6u5C6KOy")
    expect(once_again_plain_message).not_to eq(plain_message)
  end

  it "should use data from ENV var" do
    # From .env.test
    expect(encryptor.key).to eq("OLVZV7gh14iAs571ru7HUVvJjnjgAnvDwCHUXLJNyY3kvZmFfm0jSXtxQxkD45jY")
    expect(encryptor.version).to eq("XCwp5vjL6u5C6KOy")
  end

  it "should enforce `key` and `version` validation" do
    expect { encryptor.key = "too small" }.to \
      raise_error(Backdoor::Services::Security::Error, "key is invalid and succeptable to security breach")
    expect { encryptor.version = "too small" }.to \
      raise_error(Backdoor::Services::Security::Error, "version is invalid and succeptable to security breach")
  end

  it "should raise an error when key-version changes" do
    plain_message = "Secret message to encrypt"

    encryptor.key = "OLVZV7gh14iAs571ru7HUVvJjnjgAnvDwCHUXLJNyY3kvZmFfm0jSXtxQxkD45jY"
    encryptor.version = "XCwp5vjL6u5C6KOy"

    encrypted_message = encryptor.encrypt(plain_message)
    expect(encrypted_message).not_to eq(plain_message)
    expect(encrypted_message).to start_with("XCwp5vjL6u5C6KOy")

    encryptor.version = "6u5C6KOyXCwp5vjL"
    expect { encryptor.decrypt(encrypted_message) }.to \
      raise_error(Backdoor::Services::Security::Error, "version mismatch; cannot decrypt")
  end
end
