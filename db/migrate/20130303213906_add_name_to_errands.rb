class AddNameToErrands < ActiveRecord::Migration
  def change
    add_column :errands, :name, :string
  end
end
