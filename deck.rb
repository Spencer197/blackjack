=begin
require_relative 'card'

class Deck
  attr_reader :deck, :suits, :ranks
  
  SUITS = ['Spades', 'Hearts', 'Clubs', 'Diamonds']
  RANKS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'King', 'Queen', 'Ace']

  def initialize(suits, ranks)
    @deck = []
    @suits = suits
    @ranks = ranks
    create_deck
  end
  
  def shuffle
    @deck.shuffle!
  end
  
  def deal_card
    @deck.pop
  end
  
  def replace_with(new_deck)
    @suits = []
    @ranks = []
    @deck = new_deck
    
    new_deck.each do |card|
      add_suit_and_rank(card)
    end
    self#returns result of method
  end
  
  private
  #we don't want to create a deck from outside of this class, so we make create_deck private.
  def create_deck
    suits.each do |suit|
      ranks.each do |rank|
        @deck.push(Card.new(suit, rank))#push method pushes each card into the deck.
      end
    end
  end
  
  def add_suit_and_rank(card)
    suit = card.suit
    rank = card.rank
    @suits.push suit unless @suits.include? suit#Avoids pushing cards into the deck we already have.
    @ranks.push rank unless @ranks.include? rank
  end
=end

require_relative 'card'

class Deck
  SUITS = ['Spades', 'Hearts', 'Clubs', 'Diamonds']
  RANKS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']
  #A deck of cards is simply an array of 52 cards.
  attr_reader :deck, :suits, :ranks
  
  def initialize(suits, ranks)
    @deck = []
    @suits = suits
    @ranks = ranks
    create_deck
  end
  
  def shuffle
    @deck.shuffle!
  end
  
  def deal_card
    @deck.pop
  end
  
  def replace_with(new_deck)
    @suits = []
    @ranks = []
    @deck = new_deck
    
    new_deck.each do |card|
      add_suit_and_rank(card)
    end
    self
  end
  
  private 
  
  def create_deck
    suits.each do |suit|
      ranks.each do |rank|
        @deck.push(Card.new(suit, rank))
      end
    end
  end
  
  def add_suit_and_rank(card)
    suit = card.suit
    rank = card.rank
    @suits.push suit unless @suits.include? suit 
    @ranks.push rank unless @ranks.include? rank
  end
  
end

  
  