class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.date :deadline
      t.string :state
      t.integer :owner_score
      t.integer :developer_score

      t.timestamps
    end
  end
end
