class EntriesController < ApplicationController

 def index
    project = Project.find(params[:project_id])
    render json: project.entries
  end

  def create
    project = Project.find(params[:project_id])
    entry = project.entries.new(entry_params)

    if entry.save
      render json: entry, status: :created
    else
      render json: { errors: entry.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def entry_params
    params.require(:entry).permit(:project_id, :date, :task, :time, :hours)
  end
end
