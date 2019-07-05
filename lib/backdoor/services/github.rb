require "octokit"

class Backdoor::Services::GitHub
  def initialize(access_token)
    @client = Octokit::Client.new(access_token: access_token, per_page: 50)
  end

  def repos
    @client.repos({}, query: {type: "owner", sort: "asc"})
  end
end
