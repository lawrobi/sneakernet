class Offer < ActiveRecord::Base
  attr_accessible :arrival_place_id, :arriving_at, :courier_id, :description, :leaving_at, :source_place_id, :summary, :size
  belongs_to :source_place, :class_name => "Place"
  belongs_to :arrival_place, :class_name => "Place"
  belongs_to :courier, :class_name => "User"
end
