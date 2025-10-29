class AddCompletedToProjects < ActiveRecord::Migration[8.0]
  def change
    add_column :projects, :completed, :boolean, default: false, null: false
  end
end
