module Api
  module Controllers
    module Server
      class ReportList
        include Api::Action

        def call(params)
          repository = ServerRepository.new
          reports = repository.find_with_reports(params[:id]).reports.map(&:serialize)
          self.body = { reports: reports }.to_json
        end
      end
    end
  end
end
