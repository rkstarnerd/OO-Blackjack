module Player
  def hit
    cards << deck.shift
  end
end

class Victim
  attr_accessor :cards
  include Player

  @cards = []

end

class Dealer
  attr_accessor :cards
  include Player

  @cards = []
end

class Deck
  attr_accessor :deck
  def initialize
    @suits = ['Hearts', 'Spades', 'Clubs', 'Diamonds']
    @values = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']
    @deck = suits.product(values)
    deck.shuffle!
  end

  def deal(cards)
    cards << deck.shift
    cards << deck.shift
  end

  def calculate(cards)
  end
end

class Game
  attr_accessor :player, :dealer, :deck
  def initialize
    @game = Game.new
    @player = Victim.new
    @dealer = Dealer.new
    @deck = Deck.new    
  end

  def prompt
    "Would you like to Hit (1) or Stay (2)?"
    option = gets.chomp.to_i
    if option == 1
      #deal another card and calculate total
  end

  def run
    puts "\t\tLet's play Blackjack!"
    deck.deal(player.cards)
    deck.deal(dealer.cards)
    deck.calculate(player.cards)
    prompt
  end
end

game = Game.new