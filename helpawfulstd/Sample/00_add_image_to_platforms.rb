class AddImageToPlatforms < ActiveRecord::Migration[6.0]
  def change
    add_column :platforms, :image_url, :string
  end