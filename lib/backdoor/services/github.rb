require "octokit"

class Backdoor::Services::GitHub
  class Error < StandardError; end

  def initialize(access_token)
    @client = Octokit::Client.new(access_token: access_token, per_page: 50)
  end

  def repos
    @client.repos({}, query: {type: "contributors", sort: "asc"})
  rescue Octokit::Unauthorized
    raise Error, "unauthorized_access"
  rescue StandardError
    raise Error, "internal"
  end
end
