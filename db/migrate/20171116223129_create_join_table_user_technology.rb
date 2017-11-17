class CreateJoinTableUserTechnology < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :technologies do |t|
    end
  end
end
