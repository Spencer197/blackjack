require_relative 'blackjack'

RSpec.describe Blackjack do
  SUITS = ['Spades', 'Hearts', 'Clubs', 'Diamonds']
  RANKS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']
  
  before do
    @blackjack = Blackjack.new(SUITS, RANKS)  
  end
  
  describe "instance methods" do
    it "responds to #dealer_hand" do
      expect(@blackjack).to respond_to(:dealer_hand)
    end
    
    it "responds to #player_hand" do
      expect(@blackjack).to respond_to(:player_hand)
    end
    
    it "responds to #playing" do
      expect(@blackjack).to respond_to(:playing)
    end
    
    it "responds to #current_gamer" do
      expect(@blackjack).to respond_to(:current_gamer)
    end
    
    it "responds to #deck" do
      expect(@blackjack).to respond_to(:deck)
    end
    
    it "responds to #deal" do
      expect(@blackjack).to respond_to(:deal)
    end
    
    it "responds to #hit" do
      expect(@blackjack).to respond_to(:hit)
    end
    
    it "responds to #stand" do
      expect(@blackjack).to respond_to(:stand)
    end
    
    it "responds to #show_hands" do
      expect(@blackjack).to respond_to(:show_hands)
    end
    
    it "responds to #set_results" do
      expect(@blackjack).to respond_to(:set_results)  
    end
  end
  
  describe "dealing cards" do
    #Deal two cards to player & two cards to dealer.  Dealer's first card should be face down.
    before do
      @blackjack.deal
      @dealer_cards = @blackjack.dealer_hand.dealt_cards
      @player_cards = @blackjack.player_hand.dealt_cards
    end
      
     it "returns two cards for the dealer and player" do
      expect(@dealer_cards.count).to eq 2
      expect(@player_cards.count).to eq 2
    end
    
    it "does not display the dealer's first card" do
      expect(@dealer_cards.first.show).to eq false
    end
    
     it "ends the player's turn if he has a blackjack" do
      card1 = Card.new("Clubs", "10")
      card2 = Card.new("Hearts", "Ace")
      card3 = Card.new("Clubs", "3")
      
      card4 = Card.new("Diamonds", "10")
      card5 = Card.new("Diamonds", "King")
      card6 = Card.new("Hearts", "Queen")
      
      @blackjack = Blackjack.new(SUITS, RANKS)
      
      new_deck = [card4, card5, card2, card3, card1, card6]#This rigged deaing gives the player a 'blackjack' hand, ending his turn.
      @blackjack.deck.replace_with new_deck
      @blackjack.deal
      expect(@blackjack.current_gamer).to eq('Dealer')#After cards are dealt, the dealer starts his turn.
    end
  end
  
  describe "hitting a hand" do
    before do
      @blackjack.deal
      @dealer_cards = @blackjack.dealer_hand.dealt_cards
      @player_cards = @blackjack.player_hand.dealt_cards
    end
    it "can hit if @playing is set to true" do
      expect(@blackjack.playing).to eq true
  end
    it "returns 2 cards for dealer, but after a hit, the player will have 3 cards" do
      @blackjack.hit
      
      expect(@dealer_cards.count).to eq 2
      expect(@player_cards.count).to eq 3
    end
    it "determines if player is bausted" do
      #player cards
      card1 = Card.new("Clubs", "10")
      card2 = Card.new("Hearts", "10")
      card3 = Card.new("Diamonds", "2")
      #dealer cards
      card4 = Card.new("Spades", "10")
      card5 = Card.new("Clubs", "10")
      card6 = Card.new("Hearts", "Queen")
      
      @blackjack = Blackjack.new(SUITS, RANKS)
      
      new_deck = [card6, card3, card2, card5, card1, card4]#This rigged deaing gives the player a 'blackjack' hand, ending his turn.
      @blackjack.deck.replace_with new_deck
      @blackjack.deal
      @blackjack.hit
      expect(@blackjack.result).to eq("Player Busted!")#After cards are dealt, the dealer starts his turn.
    end
    it "determines if dealer is bausted" do
      #player cards
      card1 = Card.new("Clubs", "10")
      card2 = Card.new("Hearts", "10")
      card3 = Card.new("Diamonds", "Ace")
      #dealer cards
      card4 = Card.new("Spades", "10")
      card5 = Card.new("Clubs", "10")
      card6 = Card.new("Hearts", "Queen")
      
      @blackjack = Blackjack.new(SUITS, RANKS)
      
      new_deck = [card6, card3, card2, card5, card1, card4]#This rigged deaing gives the player a 'blackjack' hand, ending his turn.
      @blackjack.deck.replace_with new_deck
      @blackjack.deal
      @blackjack.hit#Player stands
      
      @blackjack.current_gamer = "Dealer"
      @blackjack.hit#The dealer takes a hit and is then busted (dealer's hand value exceedes 21).
      expect(@blackjack.result).to eq("Dealer Busted!")#After cards are dealt, the dealer starts his turn.
    end
  end
  
  describe "standing" do
    before do
      @blackjack = Blackjack.new(SUITS, RANKS)
    end
    
    it "gamer switches to 'Dealer' when 'Player' stands" do
      #player cards
      card1 = Card.new("Clubs", "10")
      card2 = Card.new("Hearts", "10")
      card3 = Card.new("Diamonds", "Ace")
      #dealer cards
      card4 = Card.new("Spades", "10")
      card5 = Card.new("Clubs", "3")
      card6 = Card.new("Hearts", "Queen")
      
      new_deck = [card6, card3, card2, card5, card1, card4]#This rigged deaing gives the player a 'blackjack' hand, ending his turn.
      @blackjack.deck.replace_with new_deck
      @blackjack.deal
      @blackjack.hit#The player hits
      @blackjack.stand#The player stands with a hand value of 21 (blackjack).
      
      expect(@blackjack.current_gamer).to eq("Dealer")
    end
    
    it "dealer automatically hits if hand value < 17 and  dealer's first card is face up" do
      #player cards
      card1 = Card.new("Clubs", "10")
      card2 = Card.new("Hearts", "10")
      card3 = Card.new("Diamonds", "Ace")
      #dealer cards
      card4 = Card.new("Spades", "10")
      card5 = Card.new("Clubs", "3")
      card6 = Card.new("Hearts", "Queen")
      
      new_deck = [card6, card3, card2, card5, card1, card4]#This rigged deaing gives the player a 'blackjack' hand, ending his turn.
      @blackjack.deck.replace_with new_deck
      @blackjack.deal
      expect(@blackjack.dealer_hand.get_value).to eq 13#The dealer's first two cards sum to 13.
      
      @blackjack.hit#Player hits
      @blackjack.stand#Player stands
      
      expect(@blackjack.dealer_hand.get_value).to eq 23#Dealer with a hand of 13, gets Queen and is busted with 23.
      expect(@blackjack.dealer_hand.dealt_cards.first.show).to eq true
    end
  end
  
   describe "showing hands" do
    before do
      @blackjack = Blackjack.new(SUITS, RANKS)
      @blackjack.deal
    end
    
    it "displays the gamers hand" do
      expect(@blackjack.show_hands).to match(/Player's hand/)
      expect(@blackjack.show_hands).to match(/Total value:/)
      expect(@blackjack.show_hands).to match(/Dealer's hand/)
      expect(@blackjack.show_hands).to match(/Total value:/)
    end
  end


end
