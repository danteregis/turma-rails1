# == Schema Information
#
# Table name: poker_tables
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  big_blind   :integer
#  small_blind :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class PokerTable < ActiveRecord::Base
  
  has_many :users, inverse_of: :poker_table
  
  has_many :poker_rounds
  
  has_many :bets, through: :poker_rounds
  
end
