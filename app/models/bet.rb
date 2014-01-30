# == Schema Information
#
# Table name: bets
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  poker_round_id :integer
#  round_status   :string(255)
#  amount         :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Bet < ActiveRecord::Base
  belongs_to :poker_round
  belongs_to :user

  
  #scope :big_bets, -> { where("amount >= 50")}
  
  
  def self.for_round(round)
    where(poker_round_id: round.id, round_status: round.current_status)
  end
  
  def self.by_user(user_id)
    where(user_id: user_id)
  end
  
  
  def was_raise?(last_raiser_id)
    if last_raiser_id != -1
      
      last_raiser_total_bet = Bet.for_round(self.poker_round).by_user(last_raiser_id).sum(&:amount)
      my_player_total_bet = Bet.for_round(self.poker_round).by_user(self.user_id).sum(&:amount)
      
      return my_player_total_bet > last_raiser_total_bet
    else
      return self.amount > self.poker_round.poker_table.big_blind
    end
  end
  
end
