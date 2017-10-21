class AddCityCountryTelWebToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :city, :string
    add_column :users, :country, :string
    add_column :users, :tel, :integer
    add_column :users, :web, :string
  end
end
