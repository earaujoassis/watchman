# frozen_string_literal: true

module Api::Controllers::Reports
  class Show
    include Api::Action

    params do
      required(:server_id).filled(:str?)

      required(:report_id).filled(:str?)
    end

    def call(params)
      repository = ServerRepository.new
      begin
        reports = repository.find_with_reports(params[:server_id]).reports
      rescue NoMethodError
        halt 404, { error: "unknown server" }
      end
      report = reports.find { |e| e.uuid == params[:report_id] }

      if report.nil?
        halt 404, {
          error: {
            report: ["report unavailable"]
          }
        }
      end

      self.body = { report: { body: report.body } }
    end
  end
end
