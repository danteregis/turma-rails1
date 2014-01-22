class CreatePokerTables < ActiveRecord::Migration
  def change
    create_table :poker_tables do |t|
      t.integer :small_blind
      t.integer :big_blind
      t.string :name

      t.timestamps
    end
  end
end
