class ErrandOffer < ActiveRecord::Base
  attr_accessible :arriving_at, :bid, :courier_id, :errand_id, :leaving_at, :message, :status
  belongs_to :errand
  belongs_to :courier, :class_name => "User"
end
