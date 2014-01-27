class CardDeck
  def initialize
    initialize_cards
  end
  
  def initialize_cards
    @cards = []
    ["s", "h", "d", "c"].each do |suit|
      %w(A 2 3 4 5 6 7 8 9 T J Q K).each do |face|
        @cards << face + suit
      end
    end
    7.times { shuffle_cards! }
  end
  
  def shuffle_cards!
    51.downto(1) do |i|
      j = Random.rand(i+1)
      @cards[i], @cards[j] = @cards[j], @cards[i]
    end
    @current_card_index = 0
  end
  
  def draw_card!
    drawn_card = @cards[@current_card_index]
    @current_card_index += 1
    drawn_card
  end
  
  def burn_card!
    @current_card_index += 1
  end
end