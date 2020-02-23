class Card
  attr_reader :rang, :suit

  def initialize(rang, suit)
    @rang = rang
    @suit = suit
  end

  def to_s
    "#{rang}-#{suit}"
  end
end
