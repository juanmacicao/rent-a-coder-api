class CreateOffers < ActiveRecord::Migration[5.1]
  def change
    create_table :offers do |t|
      t.decimal :cost
      t.integer :estimated_time

      t.timestamps
    end
  end
end
