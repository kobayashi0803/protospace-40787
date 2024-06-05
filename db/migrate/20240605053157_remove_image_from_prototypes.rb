class RemoveImageFromPrototypes < ActiveRecord::Migration[7.0]
  def change
    remove_column :prototypes, :image, :string
  end
end
