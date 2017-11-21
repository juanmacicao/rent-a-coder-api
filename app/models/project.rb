class Project < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
  belongs_to :developer, class_name: 'User', foreign_key: :developer_id, optional: true

  has_and_belongs_to_many :technologies

  has_many :offers
  has_many :candidates, through: :offers, source: :user

  validates :name, :description, :deadline, presence: true
  validates :owner_score, :developer_score, numericality: { only_integer: true, greater_or_equal_to: 0, less_than_or_equal_to: 5 }
  validate :deadline_not_in_past

  private

  def deadline_not_in_past
    errors.add(:deadline, "must be in future") if deadline.present? && deadline < Date.today
  end
end
