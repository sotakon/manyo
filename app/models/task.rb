class Task < ApplicationRecord
  validates :name, presence: true
  validates :details, presence: true
end
