class RenameFieldFromPokerRound < ActiveRecord::Migration
  def change
    
    
    change_table :poker_rounds do |t|
      t.rename :card_deck, :card_deck_serialized
    end
    
    
    
  end
end
