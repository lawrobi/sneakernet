class AddSizeToOffer < ActiveRecord::Migration
  def change
    add_column :offers, :size, :string
  end
end
