require_relative '../authentication'

module Api
  module Controllers
    module Applications
      class View
        include Api::Action
        include Api::Authentication

        def call(params)
          repository = ApplicationRepository.new
          application = repository.find(params[:id])
          halt 404, { error: 'unknown application' } if application.nil?
          self.body = application.configuration_file
        end
      end
    end
  end
end
