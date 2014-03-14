# :no_pair, :pair, :two_pair, :trips, :straight, :flush, :full_house, :

HAND_TYPES = {
  0 => :no_pair,
  1 => :pair,
  2 => :two_pair,
  3 => :three_of_a_kind,
  4 => :straight,
  5 => :flush,
  6 => :full_house,
  7 => :four_of_a_kind,
  8 => :straight_flush
}


class Hand
  attr_reader :cards

  def initialize(cards = [])
    @cards = cards
  end

  def get_cards(dealt_cards)
    @cards += dealt_cards
  end

  def discard(discard_array)
    @cards.reject! { |card| discard_array.include?(card) }
  end



  def hand_value

  end # => :trips, :flush


  def compare(other_hand)
    own_value = self.evaluate_hand
    opp_value = other_hand.evaluate_hand


    # compare the indices of the two value arrays
    # first time one array-value is greater than the other, that hand is greater
  end # => -1, 0, or 1

  private
  def evaluate_hand

  end# => array



end