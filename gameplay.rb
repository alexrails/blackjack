# frozen_string_literal: true
require_relative 'interface'
require_relative 'validator'
require_relative 'deck'
require_relative 'player'

class Gameplay
  attr_accessor :user, :dealer, :deck
  RATE = 20
  @@round_number = 0

  def initialize
    username = Interface.new_username
    Interface.welcome_message(username)
    amount = Interface.decks_amount
    @user = Player.new(username)
    @dealer = Player.new('dealer')
    @deck = Deck.new(amount)
  end

  def controller
    @@round_number += 1
    if @@round_number > 1
     exit if Interface.ask_to_continue == 'no'
    end
    Interface.number_of_round(@@round_number)
    deck.shuffle_deck if Interface.ask_shuffled == 'yes'
    first_round
    loop do
      case Interface.ask_player_choice
      when 1
        dealers_turn
      when 2
        users_turn
        Interface.info(user)
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
      controller
    elsif user.bank > dealer.bank
      Interface.user_win_game
    else
      Interface.user_lose_game
    end
  end

  private

  def dealers_turn
    Interface.turn_message(dealer)
    if dealer.points < 17
      dealer.get_cards(1, deck)
    else
      'Pass'
    end
    dealer.secure_hand
  end

  def users_turn
    Interface.turn_message(user)
    user.get_cards(1, deck)
    user.print_hand
  end

  def open_cards
    result
    Interface.open_cards_message
    dealer.print_hand
    Interface.info(dealer)
    user.clear_hand
    dealer.clear_hand
  end

  def result
    if (user.fail? && dealer.fail?) || (user.points == dealer.points)
      Interface.user_draw_round(RATE)
      user.bank += RATE / 2
      dealer.bank += RATE / 2
    elsif (dealer.points > user.points || user.fail?) && dealer.points < 22
      Interface.user_lose
      dealer.bank += RATE
    elsif (user.points > dealer.points || dealer.fail?) && user.points < 22
      Interface.user_win_round(RATE)
      user.bank += RATE
    end
  end

  def round
    user.bank -= RATE / 2
    dealer.bank -= RATE / 2
  end

  def first_round
    deck.shuffle_deck
    round
    user.get_cards(2, deck)
    dealer.get_cards(2, deck)
    user.print_hand
    Interface.info(user)
    dealer.secure_hand
  end
end
