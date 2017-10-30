class AddProjectAndUserToOffers < ActiveRecord::Migration[5.1]
  def change
    add_reference :offers, :project, foreign_key: true
    add_reference :offers, :user, foreign_key: true
  end
end
