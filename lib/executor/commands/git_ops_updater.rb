# frozen_string_literal: true

require_relative "../helpers/chart_helpers"
require_relative "../helpers/git_helpers"

class Executor::Commands::GitOpsUpdater
  Identifier = :git_ops_updater

  attr_reader :action
  attr_reader :workdir
  attr_reader :user

  def initialize(user:, action:, workdir:)
    @action = action
    @workdir = workdir
    @user = user
  end

  class << self
    def perform!(user:, action:, workdir:)
      self.new(user: user, action: action, workdir: workdir).perform
    end
  end

  def perform
    Executor::GitHelpers.clone_project(workdir: @workdir, project: @action[:application], token: @user[:token])
    Executor::GitHelpers.config(user_name: @user[:name], user_email: @user[:git_commit_email])
    Executor::GitHelpers.context do |git|
      git.chdir do
        Executor::ChartHelpers.load_values(path: "#{@action[:managed_realm]}/#{@action[:managed_project]}/values.yaml")
        Executor::ChartHelpers.update_image_tag(tag: @action[:commit_hash])
        Executor::ChartHelpers.save_values
      end
    end
    Executor::GitHelpers.commit_all(
      commit_message: "bot: updated #{@action[:managed_project]} to #{@action[:commit_hash]}"
    )
    Executor::GitHelpers.push
  rescue Git::GitExecuteError => e
    raise Executor::Error, e.message
  end
end
