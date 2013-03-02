class CreateErrands < ActiveRecord::Migration
  def change
    create_table :errands do |t|
      t.integer :requester_id
      t.integer :assignee_id
      t.integer :source_place_id
      t.integer :arrival_place_id
      t.string :summary
      t.text :description
      t.datetime :deadline

      t.timestamps
    end
  end
end
