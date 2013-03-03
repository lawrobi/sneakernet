class AddSizeToErrand < ActiveRecord::Migration
  def change
    add_column :errands, :size, :string
  end
end
