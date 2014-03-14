class Hand


  def evaluate_hand

  end# => array

  def hand_value

  end # => :trips, :flush


  def compare(other_hand)
    own_value = self.evaluate_hand
    opp_value = other_hand.evaluate_hand


    # compare the indices of the two value arrays
    # first time one array-value is greater than the other, that hand is greater
  end # => -1, 0, or 1



end