class GroupTour < ApplicationRecord
  belongs_to :group
  belongs_to :tour
end
