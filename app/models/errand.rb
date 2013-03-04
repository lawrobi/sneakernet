class Errand < ActiveRecord::Base
  attr_accessible :estimated_price, :arrival_place_id, :assignee_id, :deadline, :description, :requester_id, :source_place_id, :summary, :size, :postal_code, :street_address, :distance, :image_url
  belongs_to :source_place, :class_name => "Place"
  belongs_to :arrival_place, :class_name => "Place"
  belongs_to :requester, :class_name => "User"
  has_many :errand_offers

  def status
    if errand_offers.find {|eo| eo.status == "completed"}
      "completed"
    elsif errand_offers.find {|eo| eo.status == "accepted"}
      "accepted"
    else
      "pending"
    end
  end
end
