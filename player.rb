# frozen_string_literal: true

require_relative 'validator'

class Player
  include Validator

  attr_accessor :name, :hand, :bank, :points, :rangs
  NAME_FORMAT = /^[a-zа-я]{5}/i.freeze
  @@players = []

  def initialize(name)
    @name = name.to_s
    @bank = 100
    validate!
    @hand = []
    @rangs = []
    @points = 0
    @@players << self
  end

  def get_cards(number, deck)
    number.times do
      @hand << deck.current_deck.shift
      temp = hand.last
      @rangs << temp.first
      count_points
    end
  end

  def print_hand
    print "#{name}'s hand - "
    hand.each do |card|
      card.each do |item|
        print item.to_s
      end
      print ' '
    end
    nil
  end

  def count_points
    case rangs.last
    when 2..10
      self.points += rangs.last
    when 'J', 'Q', 'K'
      self.points += 10
    when 'A'
      self.points += if self.points + 11 <= 21
                       11
                     else
                       1
                     end
    end
    self.points
  end

  def info
    puts '----------------------------------------------'
    puts print_hand.to_s
    puts "#{name} have #{self.points} points"
    puts "#{name}'s bank is #{bank} dollars"
    puts '----------------------------------------------'
  end

  def fail?
    true if self.points > 21
  end

  def secure_hand
    print "Dealer's hand "
    hand.size.times do
      print '*'
    end
    print "\n"
  end

  def clear_hand
    hand.clear
    self.points = 0
  end

  private

  def validate!
    raise 'Wrong Name!(String contains < 5 symbols)' if name !~ NAME_FORMAT
  end
end
