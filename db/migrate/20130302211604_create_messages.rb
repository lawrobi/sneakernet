class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :from_user_id
      t.integer :to_user_id
      t.string :subject
      t.text :body
      t.string :read_status

      t.timestamps
    end
  end
end
