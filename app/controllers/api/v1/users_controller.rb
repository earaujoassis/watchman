class Api::V1::UsersController < ApplicationController
  def index
    users = User.all
    render_json_success(users)
  end

  def show
    user = User.find(params[:id])
    render_json_success(user)
  rescue ActiveRecord::RecordNotFound
    render_json_error("User not found", :not_found)
  end

  def create
    user = User.new(user_params)

    if user.save
      render_json_success(user, :created)
    else
      render_json_error(user.errors.full_messages.join(", "))
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
