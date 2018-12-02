class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
			t.belongs_to :team, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.boolean :is_lead, null: false, default: false

      t.timestamps
    end
  end
end
