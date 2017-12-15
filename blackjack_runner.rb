require_relative 'blackjack'

SUITS = ['Spades', 'Hearts', 'Clubs', 'Diamonds']
RANKS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'King', 'Queen', 'Ace']

game = Blackjack.new(SUITS, RANKS)#Starts the game.

game.deal#Deals the cards to the player & dealer.
puts game.show_hands

while game.player_hand.get_value <= 21 do
  puts
  player_cards = game.player_hand.dealt_cards#Assigns the player's hand to var. 'player_cards'.
  puts "Do you want to hit (1) or stand (2)?"
  response = $stdin.gets.chomp
  
  if response == "1"
    puts "You chose to hit: "
    game.hit#The player hits.
    puts "Player's hand: " + game.player_hand.to_s
    puts "Dealer's hand: " + game.dealer_hand.to_s
    puts
  elsif response == "2"
    puts "You chose to stand: "
    game.stand#The player stands.
    puts "Player's hand: " + game.player_hand.to_s
    puts "Dealer's hand: " + game.dealer_hand.to_s
    puts
    break
  end
end