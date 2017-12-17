class Hand
  VALUES = {
    '2': 2,
    '3': 3,
    '4': 4,
    '5': 5,
    '6': 6,
    '7': 7,
    '8': 8,
    '9': 9,
    '10': 10,
    'Jack': 10,
    'King': 10,
    'Queen': 10,
    'Ace': 1
  }
  attr_accessor :dealt_cards
  
  def initialize
    @dealt_cards = []
  end
  
  def add_card(card)
    @dealt_cards.push(card)
  end
  
  def get_value
    #Get the rank of the dealt cards and put them in an array.
    #card_ranks = []#Assigns an empty array to card_ranks.
    #dealt_cards.each { |card| card_ranks.push(card.rank) }#Pushes each card rank into the card_ranks array.
    
    #card_ranks = dealt_cards.map { |card| card.rank }#This line replaces the two above.
    card_ranks = dealt_cards.collect { |card| card.rank }#Collect is interchangable with map & does the same function.
    
#    value = 0
#    card_ranks.each do |rank|
#      rank = rank.to_sym#Converts each card rank into a symbol.
#      value = value + VALUES[rank]#Creates a VALUES hash with 'rank' as the key and the value (at VALUES[rank]) as the value.
#    end
# reduce, acc - 0, next iteration sets acc to result of first iteration and does the calc
    value = card_ranks.reduce(0) { |acc, rank| acc + VALUES[rank.to_sym] }#This line replaces the above 5 lines.
    #Ace can have a value of 11 if the value of the total hand is less than 21.
    if card_ranks.include?('Ace')
      value += 10 if value + 10 <= 21
    end
    value#Returns the above value.
  end
  
  def to_s
    #Start with empty string.
    report = ""
    
    dealt_cards.each { |card| report += card.to_s + ", " if card.show }#Displays string if card is shown.
    
    if dealt_cards.first.show == false
      first_value = VALUES[dealt_cards.first.rank.to_sym]#Returns value of first card dealt.
      first_value += 10 if dealt_cards.first.rank == 'Ace'#Adds 10 to the value of an Ace that is dealt as a first card.
      report + "Total Value: " + (get_value - first_value).to_s#Shows player only the value of the second card dealt, not the first. 
    else
      report + "Total Value: " + get_value.to_s#Adds the total value of a hand to the string.
    end
  end
end