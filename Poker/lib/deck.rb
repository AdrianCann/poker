require 'card'

class Deck
  attr_reader :cards

  def self.generate_cards
    cards = []

    Card.suits.each do |suit|
      Card.values.each do |rank|
        cards << Card.new(suit, rank)
      end
    end

    cards
  end

  def initialize(cards = Deck.generate_cards)
    @cards = cards
  end



  def deal(n)
    dealt_cards = []

    n.times { dealt_cards << @cards.shift}

    dealt_cards
  end

  def shuffle_cards
    @cards.shuffle!
    nil
  end



end