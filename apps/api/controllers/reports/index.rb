module Api
  module Controllers
    module Reports
      class Index
        include Api::Action

        def call(params)
          repository = ServerRepository.new
          begin
            reports = repository.find_with_reports(params[:id]).reports.map(&:serialize)
          rescue NoMethodError
            halt 404, { error: "unknown server" }.to_json
          end
          self.body = { reports: reports }.to_json
        end
      end
    end
  end
end
