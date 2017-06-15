class Api::V1::ApplicationsController < Api::V1::BaseController
  # skip_before_action :authenticate_developer!, only: [:index, :show]

  # GET /applications
  def index
    if params[:developer_username].present?
      dev = Developer.find_by_key(params[:developer_username])
      @applications = dev.applications
    else
      @applications = Application.all
    end
  end

  # GET /applications/1
  def show
    set_application
    authorize @application
  end

  # POST /applications
  def create
    @application = current_user.applications.new(application_params)

    if @application.save
      render :show, status: :created
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /applications/1
  def update
    set_application
    authorize @application
    if @application.update(application_params)
      render :show, status: :ok
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  # DELETE /applications/1
  def destroy
    set_application
    authorize @application
    @application.destroy
  end

  private

  def set_application
    @application = Application.find(params[:id])
  end

  def application_params
    params.require(:application).permit(:name, :key, :description)
  end
end
