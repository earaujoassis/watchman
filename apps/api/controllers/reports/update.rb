# frozen_string_literal: true

module Api
  module Controllers
    module Reports
      class Update
        include Api::Action
        include Api::Authentication

        def call(params)
          begin
            tempfile = params[:report][:body][:tempfile]
            raise TypeError, "File is not available" if tempfile.nil?
          rescue NoMethodError, TypeError
            halt 400, {
              error: {
                report: { body: ["is missing"] }
              }
            }.to_json
          end

          report_repository = ReportRepository.new
          report = report_repository.find(params[:id])
          report_repository.update_body(report, tempfile)

          status 201, { report: report.serialize }.to_json
        end
      end
    end
  end
end
