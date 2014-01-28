class PokerRound < ActiveRecord::Base
  
  before_save :force_serialization
  
  serialize :card_deck_serialized
  
  attr_accessor :card_deck
  

  def card_deck
    @card_deck ||= CardDeck.new(card_deck_serialized)
  end
  
  # nao precisamos do setter aqui pois o attr_accessor já existe justamente para criar um setter e um getter automagicamente
  
  
  def force_serialization
    if @card_deck
      self.card_deck_serialized = @card_deck.serialize
    end
    
  end
  
end

