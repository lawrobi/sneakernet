class AddDistanceToErrands < ActiveRecord::Migration
  def change
    add_column :errands, :distance, :integer
  end
end
