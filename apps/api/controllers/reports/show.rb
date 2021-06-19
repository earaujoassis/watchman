# frozen_string_literal: true

module Api
  module Controllers
    module Reports
      class Show
        include Api::Action

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
  end
end
