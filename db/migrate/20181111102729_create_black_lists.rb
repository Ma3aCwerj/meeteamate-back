class CreateBlackLists < ActiveRecord::Migration[5.2]
  def change
    create_table :black_lists do |t|
    	t.string :token, null: false, index: true
    	t.timestamp :exp_date, null: false
    	
      t.timestamps
    end
  end
end
