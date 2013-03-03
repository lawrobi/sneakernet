class AddStreetAddressAndPostalCodeToErrands < ActiveRecord::Migration
  def change
    add_column :errands, :postal_code, :integer
    add_column :errands, :street_address, :string
  end
end
