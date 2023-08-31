# frozen_string_literal: true

module Api::Controllers::Reports
  class Index
    include Api::Action
    include Api::UserAuthentication

    params do
      required(:id).filled(:str?)
    end

    def call(params)
      repository = ServerRepository.new
      reports = repository.find_with_reports(params[:id]).reports.map(&:serialize)
      self.body = { reports: reports }
    rescue NoMethodError
      halt 404, { error: "unknown server" }
    end
  end
end
