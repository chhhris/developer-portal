class Api::V1::DevelopersController < ActionController::API
  before_action :set_developer, only: [:show, :update, :destroy]

  # GET /developers
  def index
    @developers = Developer.all
  end

  # GET /developers/1
  def show
    # render show.jbuilder
  end

  # POST /developers
  def create
    @developer = Developer.new(developer_params)

    if @developer.save
      render json: include_applications(@developer), status: :created
    else
      render json: @developer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /developers/1
  def update
    if @developer.update(developer_params)
      render json: include_applications(@developer), status: :ok
    else
      render json: @developer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /developers/1
  def destroy
    @developer.destroy
  end

  private

  def set_developer
    @developer = Developer.find(params[:id])
  end

  def developer_params
    params.require(:developer).permit(:username, :password_hash, :email)
  end
end
