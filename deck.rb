# frozen_string_literal: true

require_relative 'validator'

class Deck
  include Validator

  attr_accessor :amount, :current_deck
  attr_reader :card_rang, :card_suit

  def initialize(amount)
    @amount = amount.to_i
    @card_rang = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A']
    @card_suit = ['♢', '♣', '♡', '♠']
    @current_deck = []
    @card_rang.each do |rang|
      amount.times do
        @card_suit.each do |suit|
          @current_deck << [rang, suit]
        end
      end
    end
    validate!
  end

  def shuffle_deck
    current_deck.shuffle!
  end

  private

  def validate!
    raise 'Too much amount(>10)!' if amount > 10
  end
end
