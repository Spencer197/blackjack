require_relative 'blackjack'

SUITS = ['Spades', 'Hearts', 'Clubs', 'Diamonds']
RANKS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'King', 'Queen', 'Ace']

game = Blackjack.new(SUITS, RANKS)#Starts the game.

game.deal#Deals the cards to the player & dealer.
puts game.show_hands
game.hit#The player calls for a hit.
game.current_gamer = "Dealer"
game.hit
puts game#Displays the dealt hands.