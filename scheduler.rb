# frozen_string_literal: true

require "rubygems"
require "rufus/scheduler"

require "./lib/executor"

scheduler = Rufus::Scheduler.new

Executor.logger.info("Starting scheduler")

scheduler.every "1m", first_in: "10s", allow_overlapping: false do
  Executor.tick!
end

scheduler.join
