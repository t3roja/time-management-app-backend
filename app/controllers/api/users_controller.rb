module Api
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin

    # GET /api/users
    def index
      users = User.select(:id, :email)
      render json: users
    end

    private

    def authorize_admin
      unless current_user&.admin?
        render json: { error: "Unauthorized" }, status: :unauthorized
      end
    end
  end
end
