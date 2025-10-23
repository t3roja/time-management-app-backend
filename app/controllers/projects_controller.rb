class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin, only: %i[create destroy] 
  before_action :set_project, only: %i[ show edit update destroy ]

  # GET /projects
def index
  projects = if current_user.admin?
               Project.includes(:entries, :user)
             else
               current_user.projects.includes(:entries)
             end

  render json: projects.as_json(
    only: [:id, :name],
    methods: [:totalHours],
    include: {
      user: { only: [:id, :email] },
      entries: { only: [:id, :date, :task, :time, :hours] }
    }
  )
end

  # GET /projects/:id
  def show
    render json: @project.as_json(
      only: [:id, :name],
      include: {
        entries: { only: [:id, :date, :task, :time, :hours] }
      },
      methods: [:totalHours]
    )
  end

  # POST /projects
def create
  # Admin voi määrittää käyttäjän, muuten käytetään current_user
  user = current_user.admin? && params[:project][:user_id].present? ? User.find(params[:project][:user_id]) : current_user
  @project = user.projects.new(project_params)

  if @project.save
    render json: @project, status: :created
  else
    render json: @project.errors, status: :unprocessable_entity
  end
end


  # PATCH/PUT /projects/:id
  def update
    if @project.update(project_params)
      render json: @project, status: :ok
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def set_project
  @project = current_user.projects.find(params[:id])
end

  # DELETE /projects/:id
  def destroy
    @project.destroy
    head :no_content
  end

  private

  def set_project
    @project = current_user.projects.find(params[:id])
  end

  def authorize_admin
  render json: { error: "Unauthorized" }, status: :unauthorized unless current_user.admin?
  end

def project_params
  allowed = [:name, :description]
  allowed << :user_id if current_user&.admin?
  params.require(:project).permit(allowed)
end

end
