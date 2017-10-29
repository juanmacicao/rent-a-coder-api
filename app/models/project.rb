class Project < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
  belongs_to :developer, class_name: 'User', foreign_key: :developer_id, optional: true
  has_and_belongs_to_many :technologies

  validates :name, :description, :deadline, presence: true
  validate :deadline_not_in_past

  def deadline_not_in_past
    errors.add(:deadline, "must be in future") if deadline.present? && deadline <= Date.today
  end
end
