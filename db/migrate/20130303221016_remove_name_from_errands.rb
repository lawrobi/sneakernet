class RemoveNameFromErrands < ActiveRecord::Migration
  def up
    remove_column :errands, :name
  end

  def down
    add_column :errands, :name, :string
  end
end
