# frozen_string_literal: true

module Api
  module Controllers
    module Reports
      class Index
        include Api::Action

        def call(params)
          repository = ServerRepository.new
          reports = repository.find_with_reports(params[:id]).reports.map(&:serialize)
          self.body = { reports: reports }.to_json
        rescue NoMethodError
          halt 404, { error: "unknown server" }.to_json
        end
      end
    end
  end
end
