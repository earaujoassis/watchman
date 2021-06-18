# frozen_string_literal: true

class JsonViewer
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    puts headers["Content-Type"].include?("application/json")
    body = [body.to_json] if headers["Content-Type"].include?("application/json")
    [status, headers, body]
  end
end
