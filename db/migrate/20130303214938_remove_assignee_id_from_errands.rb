class RemoveAssigneeIdFromErrands < ActiveRecord::Migration
  def up
    remove_column :errands, :assignee_id
  end

  def down
    add_column :errands, :assignee_id, :integer
  end
end
