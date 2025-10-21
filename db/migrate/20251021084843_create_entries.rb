class CreateEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :entries do |t|
      t.references :project, null: false, foreign_key: true
      t.date :date
      t.string :task
      t.string :time
      t.integer :hours

      t.timestamps
    end
  end
end
