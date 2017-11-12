class Project < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
  belongs_to :developer, class_name: 'User', foreign_key: :developer_id, optional: true

  has_and_belongs_to_many :technologies

  has_many :offers
  has_many :candidates, through: :offers, source: :user

  validates :name, :description, :deadline, presence: true
  validates :owner_score, :developer_score, numericality: { only_integer: true, greater_or_equal_to: 0, less_than_or_equal_to: 5 }
  validate :deadline_not_in_past

  # def set_score(user, score)
  #   if user == owner
  #     set_developer_score(score)
  #   elsif user == developer
  #     set_owner_score(score)
  #   else
  #     errors.add(:owner, :invalid)
  #     errors.add(:developer, :invalid)
  #   end
  # end

  private

  def deadline_not_in_past
    errors.add(:deadline, "must be in future") if deadline.present? && deadline <= Date.today
  end

  # def set_developer_score(score)
  #   if state == 'in_progress'
  #     developer_score = score
  #     state = 'finished'
  #   else
  #     errors.add(:state, :invalid)
  #   end
  # end

  # def set_owner_score(score)
  #   if state == 'finished'
  #     owner_score = score
  #   else
  #     errors.add(:state, :invalid)
  #   end
  # end
end
