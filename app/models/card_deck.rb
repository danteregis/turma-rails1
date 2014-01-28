#app/models/card_deck.rb

class CardDeck
  
  def initialize(args = nil)
    if args.is_a?(Hash)
      initialize_by_hash(args)
    else
      initialize_empty
    end
  end
  
  def initialize_empty
    @cards = []
    @players = {}
    initialize_cards
    7.times { shuffle! }
  end
  
  def initialize_by_hash(hash)
    @cards = hash[:cards]
    @current_card_index = hash[:current_card_index]
    @players = hash[:players]
  end
  
  
  def serialize
    { cards: @cards , current_card_index: @current_card_index, players: @players }
  end
  
  
  def initialize_cards
    %w(h s c d).each do |suit|
      %w(2 3 4 5 6 7 8 9 T J Q K A).each do |face|
        @cards << face + suit
      end  
    end
  end
  
  
  def shuffle!
    51.downto(1) do |i|
      j = Random.rand(i+1)
      @cards[i], @cards[j] = @cards[j], @cards[i]
    end
    @current_card_index = 0
    
  end
  
  
  def draw_card!
    card = @cards[@current_card_index]
    @current_card_index += 1
    card
  end
  
  alias_method :draw, :draw_card!
  
  def burn_card!
    @current_card_index += 1
  end
  
  alias_method :burn, :burn_card!
  
  
  
  def deal!(number_of_players)
    groups = @cards.in_groups_of(number_of_players)
    first_cards = groups[0]
    last_cards = groups[1]
    
    0.upto(number_of_players - 1) do |current_player|
      
      @players[current_player] = [ first_cards[current_player], last_cards[current_player] ]
      
    end
    
    @current_card_index = number_of_players * 2
    
    @players
  end
  
  
end

# HEARTS, CLUBS, DIAMONDS, SPADES