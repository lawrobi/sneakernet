class Message < ActiveRecord::Base
  attr_accessible :body, :from_user_id, :read_status, :subject, :to_user_id
  belongs_to :from_user, :class_name => "User"
  belongs_to :to_user, :class_name => "User"

  def self.to_user(user)
    where(:to_user_id => user.id)
  end
end
