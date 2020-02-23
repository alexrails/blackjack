# frozen_string_literal: true

require_relative 'validator'
require_relative 'card'

class Deck
  include Validator

  attr_accessor :amount, :current_deck
  attr_reader :card_rang, :card_suit
  CARD_RANG = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A']
  CARD_SUIT = ['♢', '♣', '♡', '♠']

  def initialize(amount)
    @amount = amount.to_i
    @current_deck = generate_deck
    validate!
  end

  def generate_deck
    current_deck = []
    CARD_RANG.each do |rang|
      amount.times do
        CARD_SUIT.each do |suit|
          card = Card.new(rang, suit)
          current_deck << [card.rang, card.suit]
        end
      end
    end
    current_deck
  end

  def shuffle_deck
    current_deck.shuffle!
  end

  private

  def validate!
    raise 'Too much amount(>10)!' if amount > 10
  end
end
