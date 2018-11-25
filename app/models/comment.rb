class Comment < ApplicationRecord
  belongs_to :noteable, polymorphic: true
end
