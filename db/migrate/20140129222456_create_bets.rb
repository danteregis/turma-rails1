class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.integer :user_id
      t.integer :poker_round_id
      t.string :round_status
      t.integer :amount

      t.timestamps
    end
  end
end
