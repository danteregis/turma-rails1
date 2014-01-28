class CreatePokerRounds < ActiveRecord::Migration
  def change
    create_table :poker_rounds do |t|
      t.integer :poker_table_id
      t.string :current_status
      t.integer :current_player_id
      t.integer :last_raiser
      t.integer :dealer
      t.string :card_deck

      t.timestamps
    end
  end
end
