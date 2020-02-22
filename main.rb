require_relative 'deck'
require_relative 'player'

class Gameplay
  attr_accessor :user, :dealer, :deck
  MENU = "
    1 - Pass
    2 - Add card
    3 - Open the hand
  "
  RATE = 20
  @@round_number = 0

  def initialize
    puts "Please,enter your name:"
    username = gets.chomp.to_s
    puts "Hello, #{username}! Let's start!"
    puts "Please, enter deck's amount for game:"
    amount = gets.chomp.to_i
    @user = Player.new(username)
    @dealer = Player.new("dealer")
    @deck = Deck.new(amount)
  end

  def round
    user.bank -= RATE/2
    dealer.bank -= RATE/2
  end

  def first_round
    deck.shuffle_deck
    round
    user.get_cards(2, deck)
    dealer.get_cards(2, deck)
    user.info
    dealer.secure_hand
  end

  def menu
    @@round_number += 1
    if @@round_number > 1
      puts "Do You want to continue?(yes/no)"
      exit if gets.chomp.downcase == "no"
    end
    puts "ROUND №#{@@round_number}"
    puts "Do you want shuffle the deck?(yes/no)"
    if gets.chomp.downcase == "yes"
      deck.shuffle_deck
    end
    first_round
    loop do
      puts MENU
      n = gets.chomp.to_i
      case n
      when 1
        dealers_turn
      when 2
        users_turn
        user.info
        dealers_turn
      when 3
        open_cards
        break
      end
      if user.hand.size == 3 && dealer.hand.size == 3
        open_cards
        break
      end
    end
    if user.bank != 0 && dealer.bank != 0
      menu
    elsif user.bank > dealer.bank
      puts "YOU WINN THIS GAME!"
    else
      puts "GAME OVER!"
    end
  end

  def dealers_turn
    puts "Turn of dealer:"
    if dealer.points < 17
      dealer.get_cards(1, deck)
    else
      "Pass"
    end
    dealer.secure_hand
  end

  def users_turn
    puts "Your turn:"
    user.get_cards(1, deck)
  end

  def open_cards
    puts "======================="
    puts "OPEN CARDS!"
    result
    dealer.info
    user.clear_hand
    dealer.clear_hand
  end

  def result
    if (user.fail? && dealer.fail?) || (user.points == dealer.points)
      puts "Draw! You get #{RATE/2} dollars"
      user.bank += RATE/2
      dealer.bank += RATE/2
    elsif (dealer.points > user.points || (user.fail?)) && dealer.points < 22
      puts "You LOSE! Let's try again!"
      dealer.bank += RATE
    elsif (user.points > dealer.points || (dealer.fail?)) && user.points < 22
      puts "YOU WIN! YOU GET #{RATE} DOLLARS"
      user.bank += RATE
    end
  end
end

game = Gameplay.new
game.menu
