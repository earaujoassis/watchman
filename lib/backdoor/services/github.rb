# frozen_string_literal: true

require "octokit"

class Backdoor::Services::GitHub
  class Error < StandardError; end

  def initialize(access_token)
    @client = Octokit::Client.new(access_token: access_token, per_page: 5)
  end

  def repos
    @client.repos({}, query: {type: "all", sort: "asc"})
  rescue Octokit::Unauthorized
    raise Error, "unauthorized_access"
  rescue StandardError
    raise Error, "internal"
  end

  def user
    @client.user
  rescue Octokit::Unauthorized
    raise Error, "unauthorized_access"
  rescue StandardError
    raise Error, "internal"
  end
end
