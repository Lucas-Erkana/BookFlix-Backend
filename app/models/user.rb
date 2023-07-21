class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :reservations

  validates :full_name, presence: true, length: { minimum: 3, maximum: 20 }
  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 6 }
end
