class Project < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
  belongs_to :developer, class_name: 'User', foreign_key: :developer_id, optional: true
end
