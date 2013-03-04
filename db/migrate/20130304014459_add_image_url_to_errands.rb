class AddImageUrlToErrands < ActiveRecord::Migration
  def change
    add_column :errands, :image_url, :string
  end
end
