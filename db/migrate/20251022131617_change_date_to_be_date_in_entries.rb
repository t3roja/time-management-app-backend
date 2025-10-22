class ChangeDateToBeDateInEntries < ActiveRecord::Migration[7.0]
  def up

    change_column :entries, :date, :date, using: 'date(date)'
  end

  def down
    change_column :entries, :date, :string
  end
end
