class Player
  attr_accessor :name, :hand, :bank, :points, :rangs

  @@players = []
  RATE = 20

  def initialize(name)
    @name = name.to_s
    @bank = 100
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

  def round
    self.bank -= RATE/2
  end

  def print_hand
    print "#{self.name}'s hand - "
    self.hand.each do |card|
      card.each do |item|
        print "#{item}"
      end
      print " "
    end
  end

  def count_points
    case rangs.last
      when 2..10
        self.points += rangs.last
      when "J", "Q", "K"
        self.points += 10
      when "A"
        if self.points + 11 <= 21
          self.points += 11
        else
          self.points += 1
      end
    end
    self.points
  end

  def info
    puts "----------------------------------------------"
    puts "#{self.print_hand}"
    puts "#{self.name} have #{self.points} points"
    puts "#{self.name}'s bank is #{self.bank} dollars"
    puts "----------------------------------------------"
  end

  def fail?
    true if self.points > 21
  end

  def secure_hand
    print "Dealer's hand "
    self.hand.size.times do
      print "*"
    end
    print "\n"
  end

  def clear_hand
    self.hand.clear
    self.points = 0
  end
end
