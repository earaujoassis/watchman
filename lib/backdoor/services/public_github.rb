require "octokit"

class Backdoor::Services::PublicGitHub
  class Error < StandardError; end

  def initialize(repo)
    @repo = repo
  end

  def tags
    Octokit.tags(@repo)
  rescue Octokit::Unauthorized
    raise Error, "unauthorized_access"
  rescue StandardError
    raise Error, "internal"
  end

  def latest_tag
    self.tags[0][:name]
  rescue
    "v$#{Backdoor::VERSION}"
  end
end
