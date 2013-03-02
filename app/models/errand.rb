class Errand < ActiveRecord::Base
  attr_accessible :arrival_place_id, :assignee_id, :deadline, :description, :requester_id, :source_place_id, :summary
  belongs_to :source_place, :class_name => "Place"
  belongs_to :arrival_place, :class_name => "Place"
  belongs_to :requester, :class_name => "User"
  belongs_to :assignee, :class_name => "User"
end
