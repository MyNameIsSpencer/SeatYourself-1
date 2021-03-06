class User < ActiveRecord::Base
  has_secure_password
  has_many :reviews, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :owned_restaurants, class_name: "Restaurant", foreign_key: "owner_id", dependent: :destroy
  has_many :restaurants, through: :reservations
end
