class Api::V1::ApplicationsController

  # GET /applications
  def index
    if params[:developer_key].present?
      dev = Developer.find_by_key(params[:developer_key])
      applications = dev.applications
    else
      applications = Application.all
    end

    render json: applications
  end

  # GET /applications/1
  def show
    render json: application
  end

  # POST /applications
  def create
    application = Application.new(application_params)

    if application.save
      render json: application, status: :created, location: application
    else
      render json: application.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /applications/1
  def update
    if application.update(application_params)
      render json: application
    else
      render json: application.errors, status: :unprocessable_entity
    end
  end

  # DELETE /applications/1
  def destroy
    application.destroy
  end

  private

  def application
    Application.find(params[:id])
  end

  def application_params
    params.require(:application).permit(:name, :key, :description)
  end
end
