# frozen_string_literal: true

require "git"

module Executor
  module GitHelpers
    class << self
      def clone_project(workdir:, base_url: "github.com", project:, token:, branch: "master")
        @git = begin
          project_url = self.project_url(base_url: base_url, project: project, token: token)
          Git.clone(project_url, "project", path: workdir, branch: branch, log: Executor.logger)
        end
        self
      end

      def config(user_name:, user_email:)
        @git.config("user.name", user_name)
        @git.config("user.email", user_email)
        self
      end

      def context(&block)
        return unless block
        block.call(@git)
      end

      def commit_all(commit_message:)
        @git.add(all: true)
        @git.commit(commit_message)
        self
      end

      def push(remote: "origin")
        @git.push(@git.remote(remote))
      end

      def project_url(base_url: "github.com", project:, token:)
        "https://#{token}:x-oauth-basic@#{base_url}/#{project}.git"
      end
    end
  end
end
