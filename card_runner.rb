require_relative 'card'

suit = "Clubs"
rank = "9"

card = Card.new(suit, rank)

puts "Suit of card: #{card.suit}"
puts
puts "Rank of card: #{card.rank}"
puts
puts "Card: #{card}"
puts
card.show = false
puts "Card: #{card}"
puts
card.show = true
puts "Card: #{card}"
