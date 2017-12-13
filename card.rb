class Card
  attr_accessor :suit, :rank, :show
  SUITS = ['Spades', 'Hearts', 'Clubs', 'Diamonds']
  RANKS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'King', 'Queen', 'Ace']
  
  def initialize(suit, rank)
    @show = true
    if SUITS.include?(suit) && RANKS.include?(rank)
      @suit = suit
      @rank = rank
    else
      @suit = "UNKNOWN"#Tells user 'I don't recognize the card you're trying to enter'.
      @rank = "UNKNOWN"
    end
  end
  
  def to_s
    if show
      "#{rank} of #{suit}"
    else
      ""
    end
  end
end