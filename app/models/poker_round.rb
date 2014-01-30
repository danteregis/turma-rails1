# == Schema Information
#
# Table name: poker_rounds
#
#  id                   :integer          not null, primary key
#  poker_table_id       :integer
#  current_status       :string(255)
#  current_player_id    :integer
#  last_raiser          :integer
#  dealer               :integer
#  card_deck_serialized :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#

class PokerRound < ActiveRecord::Base
  
  ROUND_STATUS_PREFLOP  = "preflop"
  ROUND_STATUS_FLOP     = "flop"
  ROUND_STATUS_TURN     = "turn"
  ROUND_STATUS_RIVER    = "river"
  
  validate :current_status, inclusion: [ROUND_STATUS_PREFLOP, ROUND_STATUS_FLOP, ROUND_STATUS_TURN, ROUND_STATUS_RIVER]
  
  before_save :force_serialization
  
  serialize :card_deck_serialized
  
  attr_accessor :card_deck
  
  has_many :bets
  
  belongs_to :poker_table
  

  def card_deck
    @card_deck ||= CardDeck.new(card_deck_serialized)
  end
  
  # nao precisamos do setter aqui pois o attr_accessor já existe justamente para criar um setter e um getter automagicamente
  
  
  
  def start_round!
    number_of_players = poker_table.users.count
    card_deck.deal!(number_of_players)
    self.current_status = ROUND_STATUS_PREFLOP
    set_dealer
    place_blinds_bets
    self.current_player_id = next_user_id
    save
  end
  
  def next_user_id
    number_of_players = poker_table.users.count
    current_position = get_user_position_by_id(current_player_id)
    current_position ||= big_blind_position
    if current_position == number_of_players -1
      get_user_id_by_position 0
    else
      get_user_id_by_position current_position + 1
    end
  end
  
  
  def get_user_position_by_id(user_id)
    poker_table.user_ids.index(user_id)
  end
  
  def get_user_id_by_position(position)
    poker_table.users[position].id
  end

  
  def place_blinds_bets
    self.update(last_raiser: -1)
    place_bet(small_blind_user.id, poker_table.small_blind)
    place_bet(big_blind_user.id, poker_table.big_blind)
  end
  
  def place_bet(user_id, bet_amount)  

      ActiveRecord::Base.transaction do
        user = User.find(user_id)
        user.update!(money: user.money - bet_amount)
        bet = self.bets.create!(user_id: user_id, amount: bet_amount, round_status: self.current_status)
      
        if bet.was_raise?(self.last_raiser)
          self.update!(last_raiser: user_id)
        end
      end   

  end
  
  
  def set_dealer
    previous_round = poker_table.poker_rounds.where("id < ?", self.id).order(:id).last
    last_dealer = if previous_round
      previous_round.dealer || 0
    else
      0
    end
    
    if last_dealer == poker_table.users.count-1
      self.dealer = 0
    else
      self.dealer = last_dealer + 1
    end
  end
  
  
  def dealer_user
    self.poker_table.users[dealer]
  end
  
  def small_blind_position
    if (dealer == poker_table.users.count-1)
      return 0
    else
      return dealer + 1
    end
  end
  
  def small_blind_user
    self.poker_table.users[small_blind_position]
  end
  
  def big_blind_position
    if small_blind_position == poker_table.users.count-1
      return 0
    else
      return small_blind_position + 1
    end
  end
  
  def big_blind_user
    poker_table.users[big_blind_position]
  end
  
  
  
  
  
  
  
  def force_serialization
    if @card_deck
      self.card_deck_serialized = @card_deck.serialize
    end
    
  end
  
end

