class EntriesController < ApplicationController
  before_action :set_project
  before_action :set_entry, only: [:show, :update, :destroy]

  def index
    render json: @project.entries
  end

  def show
    render json: @entry
  end

  def create
    entry = @project.entries.new(entry_params)
    if entry.save
      render json: entry, status: :created
    else
      render json: { errors: entry.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @entry.update(entry_params)
      render json: @entry, status: :ok
    else
      render json: { errors: @entry.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @entry.destroy
    head :no_content
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_entry
    @entry = @project.entries.find(params[:id])
  end

  def entry_params
    params.require(:entry).permit(:date, :task, :time, :hours)
  end
end
