class AddOwnerAndDeveloperToProjects < ActiveRecord::Migration[5.1]
  def change
    add_reference :projects, :owner, index: true
    add_reference :projects, :developer, index: true

    add_foreign_key :projects, :users, column: :owner_id
    add_foreign_key :projects, :users, column: :developer_id
  end
end
