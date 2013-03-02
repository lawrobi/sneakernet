class Place < ActiveRecord::Base
  attr_accessible :city, :country, :display_name, :postal_code, :state
end
