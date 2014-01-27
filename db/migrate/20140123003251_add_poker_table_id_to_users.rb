class AddPokerTableIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :poker_table_id, :integer
    add_index :users, :poker_table_id
  end
end
