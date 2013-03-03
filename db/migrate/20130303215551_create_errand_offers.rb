class CreateErrandOffers < ActiveRecord::Migration
  def change
    create_table :errand_offers do |t|
      t.integer :errand_id
      t.integer :courier_id
      t.integer :bid
      t.datetime :leaving_at
      t.datetime :arriving_at
      t.string :status
      t.text :message

      t.timestamps
    end
  end
end
