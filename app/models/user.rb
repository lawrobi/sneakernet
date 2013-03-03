class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :authentications
  has_many :inbox, :class_name => "Message", :foreign_key => :to_user_id
  belongs_to :home_place, :class_name => "Place"

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :home_place_id, :name, :email, :password, :password_confirmation
end
