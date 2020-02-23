# frozen_string_literal: true

module Interface
  module_function

  MENU = "
    1 - Pass
    2 - Add card
    3 - Open the hand
  "

  def new_username
    puts 'Please, enter your name:'
    gets.chomp
  end

  def welcome_message(username)
    puts "Hello, #{username}! Let's start!"
  end

  def decks_amount
    puts "Please, enter deck's amount for game:"
    gets.chomp.to_i
  end

  def info(user)
    puts '---------------------------'
    puts "#{user.name} have #{user.points} points"
    puts "#{user.name}'s bank is #{user.bank} dollars"
  end

  def ask_player_choice
    puts MENU
    gets.chomp.to_i
  end

  def ask_to_continue
    puts 'Do you want to continue?(yes/no)'
    gets.chomp.downcase
  end

  def ask_shuffled
    puts 'Do you want shuffle the deck?(yes/no)'
    gets.chomp.downcase
  end

  def number_of_round(number)
    puts "ROUND №#{number}"
  end

  def user_win_round(rate)
    puts "CONGRATULATION! You get #{rate}! dollars"
  end

  def user_draw_round(rate)
    puts "DRAW! You get #{rate / 2} dollars"
  end

  def user_lose
    puts 'SORRY! You LOSE!'
  end

  def user_win_game
    puts 'YOU WINN THIS GAME!'
  end

  def user_lose_game
    puts 'GAME OVER!'
  end

  def turn_message(user)
    puts "Turn of #{user.name}"
  end

  def open_cards_message
    puts '======================='
    puts 'OPEN CARDS!'
  end
end
