class Api::V1::SessionsController < Api::V1::BaseController

  def create
    user = User.find_by(email: session_params[:email])

    # CHANGE ME
    if user && user.authenticate(create_params[:password])
      self.current_user = user
      render(
        json: Api::V1::SessionSerializer.new(user, root: false).to_json,
        status: 201
      )
    else
      return api_error(status: 401)
    end
  end


  private

  def session_params
    params.require(:user).permit(:email, :password)
  end

end