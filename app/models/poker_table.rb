class PokerTable < ActiveRecord::Base
  
  has_many :users, inverse_of: :poker_table
  
end
