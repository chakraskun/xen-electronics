module Api
  class AuthenticationController < ::ApplicationController
    before_action :authorize_request, except: :login
  
    def login
      user = User.find_by_email(params[:email])
      if user&.authenticated?(params[:password])
        token = encode_token(user_id: user.id)
        render json: ::Dto::BaseResponse.ok(
          data: {
            token: token,
            user: user,
          }
        )
      else
        render json: { error: 'unauthorized' }, status: :unauthorized
      end
    end

    private
  
    def login_params
      params.permit(:email, :password)
    end
  end
end