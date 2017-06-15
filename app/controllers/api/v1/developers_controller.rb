class Api::V1::DevelopersController < Api::V1::BaseController

  # GET /developers
  def index
    @developers = Developer.all
  end

  # GET /developers/1
  def show
    set_developer
  end

  # POST /developers
  def create
    @developer = Developer.new(developer_params)

    if @developer.save
      render :show, status: :created
    else
      render json: @developer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /developers/1
  def update
    set_developer
    if @developer.update(developer_params)
      render :show, status: :ok
    else
      render json: @developer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /developers/1
  def destroy
    set_developer
    @developer.destroy
  end

  private

  def set_developer
    @developer = Developer.find(params[:id])
  end

  def developer_params
    params.require(:developer).permit(:username, :password, :email)
  end
end
