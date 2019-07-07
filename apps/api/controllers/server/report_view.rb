module Api
  module Controllers
    module Server
      class ReportView
        include Api::Action

        def call(params)
          repository = ServerRepository.new
          reports = repository.find_with_reports(params[:server_id]).reports
          report = reports.find { |e| e.uuid == params[:report_id] }

          if report.nil?
            halt 404, {
              error: {
                report: ["report unavailable"]
              }
            }.to_json
          end

          self.body = { report: { body: report.body } }.to_json
        end
      end
    end
  end
end
