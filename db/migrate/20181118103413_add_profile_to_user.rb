class AddProfileToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :fullname, :string, index: true
    add_column :users, :show_email, :boolean, null: false, default: false
    add_column :users, :picture, :string
    add_column :users, :about, :text, index: true
    add_column :users, :city, :string, index: true
    add_column :users, :birthday, :date
  end
end
