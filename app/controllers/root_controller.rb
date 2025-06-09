class RootController < ApplicationController
  def index
    render json: { message: "root" }
  end
end
