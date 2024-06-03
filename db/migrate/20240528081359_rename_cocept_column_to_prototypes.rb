class RenameCoceptColumnToPrototypes < ActiveRecord::Migration[7.0]
  def change
    rename_column :prototypes, :cocept, :concept
  end
end
