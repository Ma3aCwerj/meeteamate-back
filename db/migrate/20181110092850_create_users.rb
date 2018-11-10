class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, null: false, index: { unique: true }
      t.string :password_digest, null: false
      t.boolean :is_admin, null: false, default: false 
      t.boolean :is_banned, null: false, default: false
      t.timestamp :exp_ban

      t.timestamps
    end
  end
end
