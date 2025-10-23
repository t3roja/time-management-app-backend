class ApplicationController < ActionController::API
        include DeviseTokenAuth::Concerns::SetUserByToken

        def render_create_success
        render json: {
                status: 'success',
                data: resource_data(resource_json: @resource.token_validation_response)
                .merge(is_admin: @resource.admin)
        }
  end
end
