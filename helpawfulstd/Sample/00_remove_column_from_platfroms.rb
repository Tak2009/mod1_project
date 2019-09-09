class RemoveColumnFromPlatfroms < ActiveRecord::Migration[6.0]
  def change
    remove_column :platforms, :name, :string
  end
end
