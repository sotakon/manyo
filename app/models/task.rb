class Task < ApplicationRecord
  validates :name, presence: true
  validates :details, presence: true
  enum task_status:{未着手:1, 着手中:2, 完了:3}
  scope :search_name, -> (name){ where("name LIKE?","%#{name}%") }
  scope :search_status, -> (status){ where(status: status) }
end
