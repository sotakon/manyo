class Task < ApplicationRecord
  validates :name, presence: true
  validates :details, presence: true
  enum task_status:{未着手:1, 着手中:2, 完了:3}
  enum priority:{高:1, 中:2, 低:3}
  scope :search_name, -> (name){ where("name LIKE?","%#{name}%") }
  scope :search_status, -> (status){ where(status: status) }
  scope :search_priority, -> (priority){ where(priority: priority) }
end
