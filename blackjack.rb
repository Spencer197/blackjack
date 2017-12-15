require_relative 'deck'
require_relative 'hand'

class Blackjack
  
  attr_reader :player_hand, :dealer_hand, :playing, :deck
  attr_accessor :current_gamer, :result
  
  def initialize(suits, ranks)
    @player_hand = nil
    @dealer_hand = nil
    @deck = Deck.new(suits, ranks)
    @deck.shuffle
    @playing = false
    @current_gamer = 'Player'
    @result = ''
  end
  
  def deal
    unless @playing
      @player_hand = Hand.new
      @dealer_hand = Hand.new
      
      2.times do
        dealer_hand.add_card(@deck.deal_card)
        player_hand.add_card(@deck.deal_card)
      end
    end
    dealer_hand.dealt_cards.first.show = false
    @playing = true
    values_of_ten = ['10', 'Jack', 'Queen', 'King']
    player_cards = player_hand.dealt_cards
    
    if values_of_ten.include?(player_cards.first.rank) &&
      player_cards.last.rank == 'Ace' ||#If the players cards include a value_of_ten card & a last card of Ace, or...
      player_cards.first.rank == 'Ace' &&
      values_of_ten.include?(player_cards.last.rank)#if the player's first card is an Ace & then a values_of_ten card (blackjack),
      @current_gamer = 'Dealer'#the dealer begins his turn.
    end
  end
  
  def hit
    # dealing a new card to the player, current_gamer = player, playing is true
    if playing
      if current_gamer == "Player"
        add_new_card player_hand
      elsif current_gamer == "Dealer"
        add_new_card dealer_hand
      end
    end
  end
  
  def stand#When player 'stands', the dealer becomes the current_gamer.
    if @playing
      if current_gamer == "Player"
        @current_gamer = "Dealer"
        dealer_hand.dealt_cards.first.show = true#Shows the dealer's first card.
      end
      
      while dealer_hand.get_value < 17
        hit
      end
    end
  end
  
  def show_hands
    "Player's hand: #{player_hand}\nDealer's hand: #{dealer_hand}"
  end

  
  def set_results
    
  end
=begin  
  def to_s
    puts "Player's Hand: #{player_hand.get_value}"
    puts "Player has #{player_hand.dealt_cards.count} cards."
    puts "Dealer's Hand: #{dealer_hand.get_value}"
    puts "Dealer has #{dealer_hand.dealt_cards.count} cards."
=end
  
  
  private
  
  def add_new_card(hand)
    hand.add_card(@deck.deal_card)
    
    if hand.get_value > 21
      @result = "#{current_gamer} Busted!"
      @playing = false
    end
  end
end