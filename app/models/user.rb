class User < ApplicationRecord
  has_secure_password

  has_many :tour_guests
  has_many :payments
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :tour_guests
  has_many :tour_users
  has_many :tours, through: :tour_users
  has_many :comments, as: :noteable

  validates :email, uniqueness: true
  validates :first_name, presence: true,  length: { minimum: 2 }
  validates :last_name, presence: true,  length: { minimum: 2 }

  scope :role, -> (role) {joins(:roles).where('roles.title = ?', "#{role}")}

  attr_accessor :old_password

  def formatted_name
    "#{first_name} #{last_name}"
  end

  def self.search(search)
    if search
      name = search.split(' ')
      if name.length < 2
        where('first_name LIKE :search OR last_name LIKE :search', search: "%#{name[0]}%")
      else
        where("first_name LIKE ? AND last_name LIKE ?", "%#{name[0]}","%#{name[1]}")
      end
    else
      all
    end
  end

end
