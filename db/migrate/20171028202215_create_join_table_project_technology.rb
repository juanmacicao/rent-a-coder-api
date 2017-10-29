class CreateJoinTableProjectTechnology < ActiveRecord::Migration[5.1]
  def change
    create_join_table :projects, :technologies do |t|
    end
  end
end
