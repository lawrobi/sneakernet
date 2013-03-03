class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.integer :courier_id
      t.integer :source_place_id
      t.integer :arrival_place_id
      t.datetime :leaving_at
      t.datetime :arriving_at
      t.string :summary
      t.text :description

      t.timestamps
    end
  end
end
