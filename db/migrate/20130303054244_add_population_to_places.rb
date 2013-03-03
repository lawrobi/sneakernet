class AddPopulationToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :population, :integer
  end
end
