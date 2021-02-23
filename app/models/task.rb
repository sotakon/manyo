class Task < ApplicationRecord
  validates :name, details: true
end
