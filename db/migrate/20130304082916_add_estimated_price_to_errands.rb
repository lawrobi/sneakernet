class AddEstimatedPriceToErrands < ActiveRecord::Migration
  def change
    add_column :errands, :estimated_price, :integer
  end
end
