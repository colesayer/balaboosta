class User < ApplicationRecord
  has_secure_password

  has_many :tour_guests
  has_many :payments
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :tour_guests

  validates :email, uniqueness: true
  validates :first_name, presence: true,  length: { minimum: 2 }
  validates :last_name, presence: true,  length: { minimum: 2 }

  def formatted_name
    "#{first_name} #{last_name}"
  end
end
