class CreatePokerTables < ActiveRecord::Migration
  def change
    create_table :poker_tables do |t|
      t.string :name
      t.integer :big_blind
      t.integer :small_blind

      t.timestamps
    end
  end
end
