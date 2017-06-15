class Api::V1::TokensController < Api::V1::BaseController
  skip_before_action :authenticate_developer!, only: [:show]

  def index
    @developer = Developer.find_by_email(params[:email])

    if @developer && @developer.password == params[:password]
      render :index, status: :ok
    else
      render json: { error: 'Email and/or password not found'}, status: :unprocessable_entity
    end
  end


  private

  def session_params
    params.require(:user).permit(:email, :password)
  end

end