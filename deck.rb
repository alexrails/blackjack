class Deck
  attr_accessor :amount, :card_rang, :card_suit, :current_deck
  def initialize(amount)
    @amount = amount.to_i
    @card_rang = [ 2, 3, 4, 5, 6, 7, 8, 9, 10, "J", "Q", "K", "A" ]
    @card_suit = [ "♢", "♣", "♡", "♠" ]
    @current_deck = []
    @card_rang.each do |rang|
      amount.times do
        @card_suit.each do |suit|
          @current_deck << [rang, suit]
        end
      end
    end
  end

  def shuffle_deck
    self.current_deck.shuffle!
  end
end
