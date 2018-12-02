class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :title, null: false, index: true
      t.string :summary, null: false, index: true
      t.text :body
      t.string :picture
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
