class Offer < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validates :cost, :estimated_time, presence: true
  validates :cost, format: { with: /\A[0-9]+(.[0-9]+)?\z/ }, numericality: { greater_than: 0, less_than_or_equal_to: 10000000 }
  validates :estimated_time, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 365 }
end
