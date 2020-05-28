class UsersController < ApplicationController
skip_before_action :authenticate_request, only: [:login]


  def login
    authenticate params[:email], params[:password]
  end

  private

  def authenticate(email, password)
    auth_token = AuthenticateUser.call(email, password)

    if auth_token.success?
      user = User.find_by_email(email)
      render json: {
        status: 200,
        auth_token: auth_token.result,
        role: user.is_admin ? "admin" : "user",
        email: user.email,
        message: 'Login Successful'
      }
    else
      render json: { message: "Invalid Credentials" , status: 401}
    end
   end
end
