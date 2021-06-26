# frozen_string_literal: true

module Api::Controllers::Reports
  class Update
    include Api::Action
    include Api::Authentication

    def call(params)
      tempfile = params[:report][:body][:tempfile]
      raise TypeError, "File is not available" if tempfile.nil?

      report_repository = ReportRepository.new
      report = report_repository.find(params[:id])
      report_repository.update_body(report, tempfile)

      self.body = { report: report.serialize }
    rescue NoMethodError, TypeError
      halt 400, {
        error: {
          report: { body: ["is missing"] }
        }
      }
    end
  end
end
