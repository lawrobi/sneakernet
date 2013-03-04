class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :authentications
  has_many :inbox, :class_name => "Message", :foreign_key => :to_user_id
  has_many :requested_errands, :class_name => "Errand",
           :foreign_key => :requester_id
  has_many :offers, :class_name => "Offer",
           :foreign_key => :courier_id
  has_many :errand_offers_as_courier, :class_name => "ErrandOffer",
           :foreign_key => :courier_id
  belongs_to :home_place, :class_name => "Place"

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :bios
  attr_accessible :home_place_id, :name, :email, :password, :password_confirmation, :image_url

  def requested_errands_completed
    requested_errands.select { |errand|
      errand.errand_offers.find {|eo| eo.status == "completed" }
    }
  end

  def requested_errands_pending
    requested_errands - requested_errands_completed
  end

  def errand_offers_completed
    errand_offers_as_courier.select {|eo| eo.status == "completed"}
  end

  def errand_offers_pending
    errand_offers_as_courier - errand_offers_completed
  end

  def large_image_url
    image_url.sub("type=square","type=large") if image_url
  end
end
