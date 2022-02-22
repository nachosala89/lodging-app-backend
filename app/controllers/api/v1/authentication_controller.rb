class Api::V1::AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate
  def authenticate
    auth_token =
      AuthenticateUser.new(auth_params[:name]).call
    json_response(auth_token: auth_token)
  end

  private

  def auth_params
    params.permit(:name)
  end
end
