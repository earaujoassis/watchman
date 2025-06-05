class RootController < Api::V1::BaseController
  def index
    render json: { message: "root" }
  end
end
