class Player
  attr_accessor :cards

  def initialize
    @cards = []
  end
end

class Deck
  attr_accessor :deck, :suits, :values, :total

  def initialize
    @suits = ['Hearts', 'Spades', 'Clubs', 'Diamonds']
    @values = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']
    @deck = suits.product(values)
    deck.shuffle!
  end

  def deal(cards)
    2.times { cards << deck.shift }
  end

  def calculate(cards)
    array = cards.map {|e| e[1]}
  
    total = 0

    array.each do |value|
      if value == 'Ace'
        total += 11
      elsif value.to_i == 0
        total += 10
      else
        total += value.to_i
      end
    end

    array.select { |e| e == 'Ace'}.count.times {total -= 10 if total > 21}
    total
  end

  def hit(cards)
    cards << deck.shift
  end

  def tell_hand(cards, player_total)
    hand = ""
    cards.each {|card| hand << "#{card[1]} of #{card[0]}, "}
    puts "You have #{hand} for a total of #{player_total}"
  end
end

class Game
  attr_accessor :player, :dealer, :deck, :player_total, :dealer_total, :hit_stay
  def initialize
    @player = Player.new
    @dealer = Player.new
    @deck = Deck.new
  end

  def prompt
    puts "Would you like to Hit (1) or Stay (2)?"
    @hit_stay = gets.chomp

    while hit_stay == '1' && player_total < 21
      deck.hit(player.cards)
      @player_total = deck.calculate(player.cards)
      deck.tell_hand(player.cards, player_total)
      check_for_winner
    end

    while (hit_stay == '2') && (dealer_total < 17)
        deck.hit(dealer.cards)
        @dealer_total = deck.calculate(dealer.cards)
        puts "The dealer has less than 17 and will hit."
    end

    if (hit_stay == '2') && (dealer_total >= 17)
      puts "Your total is #{player_total} and the dealer has #{dealer_total}"
      check_for_winner
    else
      puts "Please enter a valid response."
      prompt
    end
  end

  def check_for_winner
    if player_total == 21
       puts "Blackjack!  You won!"
       play_again
      elsif player_total > 21
        puts "Busted! You lost.."
        play_again
      elsif dealer_total == 21
        puts "Dealer has Blackjack! You lost.."
        play_again
      elsif dealer_total > 21
        puts "Dealer is Busted!  You won!"
        play_again
      elsif hit_stay == '1'
        prompt
      elsif (hit_stay == '2') && (player_total <= 21) && (player_total > dealer_total)
        puts "You won!"
        play_again
      elsif (hit_stay == '2') && (player_total <= 21) && (player_total <= dealer_total)
        puts "You lost.."
        play_again
      else
        prompt
    end
  end

  def run
    puts "\t\tLet's play Blackjack!"
    deck.deal(player.cards)
    deck.deal(dealer.cards)
    @player_total = deck.calculate(player.cards)
    deck.tell_hand(player.cards, player_total)
    puts "The dealer is showing #{dealer.cards[1]}"
    @dealer_total = deck.calculate(dealer.cards)
    check_for_winner
  end

  def play_again
    puts "Would you like to play again?"
    answer = gets.chomp.upcase
    if answer.include? "Y"
      Game.new.run
    else
      puts "Thanks for playing!"
    end
  end
end

Game.new.run