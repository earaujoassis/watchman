# frozen_string_literal: true

require "rubygems"
require "rufus/scheduler"

require "./lib/executor"

scheduler = Rufus::Scheduler.new

Executor.logger.info("Starting scheduler")

scheduler.every "30s", first_in: "1min", allow_overlapping: false do
  Executor.tick!
end

scheduler.join
