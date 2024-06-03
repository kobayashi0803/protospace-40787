class RenameCoceptColumnToPrototypes < ActiveRecord::Migration[6.0]
  def change
    # 正しいカラム名に修正
    rename_column :prototypes, :cocept, :concept
  end
end
