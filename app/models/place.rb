class Place < ActiveRecord::Base
  attr_accessible :city, :country, :display_name, :postal_code, :state
  has_many :users, :foreign_key => :home_place_id
  has_many :errands_departing, :class_name => "Errand", :foreign_key => :source_place_id
  has_many :errands_arriving, :class_name => "Errand", :foreign_key => :arrival_place_id
  has_many :offers_departing, :class_name => "Offer", :foreign_key => :source_place_id
  has_many :offers_arriving, :class_name => "Offer", :foreign_key => :arrival_place_id
end
