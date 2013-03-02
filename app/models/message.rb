class Message < ActiveRecord::Base
  attr_accessible :body, :from_user_id, :read_status, :subject, :to_user_id
end
