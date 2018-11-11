class CreateTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :tokens do |t|
    	t.json :user_agent
    	t.string :token, null: false, index: true
    	t.references :user

      t.timestamps
    end
  end
end
