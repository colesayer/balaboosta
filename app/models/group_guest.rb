class GroupGuest < ApplicationRecord
  belongs_to :group
  belongs_to :guest
end
