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
    HAND_TYPES[evaluate_hand[0]]
  end # => :trips, :flush


  def beats(other_hand)
    own_value = evaluate_hand
    opp_value = other_hand.evaluate_hand

    own_value.each_index do |i|
      return 1  if own_value[i] > opp_value[i]
      return -1 if opp_value[i] > own_value[i]
    end

    0
    # compare the indices of the two value arrays
  # first time one array-value is greater than the other, that hand is greater
  end # => -1, 0, or 1

  protected
  def evaluate_hand
    value_arr = []
    rank_counts = freq_hash
    if rank_counts.keys.count == 5
      eval_no_pair_hand(rank_counts) #
    else
      eval_pair_hand(rank_counts)
    end
  end# => array

  private
  def freq_hash
    rank_counts = Hash.new(0)
    cards.each do |card|
      rank_counts[card.val] += 1
    end
    rank_counts
  end

  def eval_no_pair_hand(rank_counts)

    is_flush = is_flush?
    is_straight = is_straight?(rank_counts)

    return assign_str_fls(rank_counts) if is_flush && is_straight
    return assign_fls(rank_counts) if is_flush
    return assign_str(rank_counts) if is_straight

    assign_high_card(rank_counts)
  end


  def is_flush?
    suit_to_check = cards.first.suit
    cards.all? { |card| card.suit == suit_to_check }
  end

  def is_straight?(rank_counts)
    sorted_ranks = rank_counts.keys.sort
    # Check if there is an Ace; if so there may be a straight: A-2-3-4-5
    if sorted_ranks.include? 14
      return true if [14, 2, 3, 4, 5].all? { |rank| sorted_ranks.include?(rank) }
    end

    is_straight = true
    sorted_ranks.each_index do |i|
      next if (i + 1) == sorted_ranks.length
      is_straight &&= (sorted_ranks[i + 1] - sorted_ranks[i] == 1)
    end
    is_straight
  end

  def assign_str_fls(rank_counts)
    [8, rank_counts.keys.min]
  end

  def assign_fls(rank_counts)
    [5] + rank_counts.keys.sort.reverse
  end

  def assign_str(rank_counts)
    [4, rank_counts.keys.min]
  end

  def assign_high_card(rank_counts)
    [0] + rank_counts.keys.sort.reverse
  end


  def eval_pair_hand(rank_counts)
    max_freq = rank_counts.values.max

    if max_freq == 2
      eval_pairs(rank_counts)
    elsif max_freq == 3
      eval_trips(rank_counts)
    else
      assign_four_kind(rank_counts)
    end
  end

  def eval_pairs(rank_counts)
    if rank_counts.keys.count == 4
      assign_pr(rank_counts)
    else
      assign_two_pr(rank_counts)
    end
  end

  def assign_pr(rank_counts)
    sorted_ranks = rank_counts.keys.sort.reverse
    pair_rank = rank_counts.detect { |rank, count| count == 2}.first
    sorted_ranks.delete(pair_rank)

    [1, pair_rank] + sorted_ranks
  end

  def assign_two_pr(rank_counts)

    sorted_ranks = rank_counts.keys.sort.reverse
    unpair_rank = rank_counts.detect { |rank, count| count == 1 }.first
    sorted_ranks.delete(unpair_rank)

    [2] + sorted_ranks + [unpair_rank]
  end

  def eval_trips(rank_counts)
    if rank_counts.keys.count == 2
      assign_full_hs(rank_counts)
    else
      assign_three_kd(rank_counts)
    end
  end

  def assign_full_hs(rank_counts)
    sorted_ranks = rank_counts.keys
    sorted_ranks.reverse! if (rank_counts[sorted_ranks[0]] == 2)
    [6] + sorted_ranks
  end

  def assign_three_kd(rank_counts)
    sorted_ranks = rank_counts.keys.sort.reverse
    three_rank = rank_counts.detect { |rank, count| count == 3}.first
    sorted_ranks.delete(three_rank)

    [3, three_rank] + sorted_ranks
  end

  def assign_four_kind(rank_counts)
    sorted_ranks = rank_counts.keys
    sorted_ranks.reverse! if (rank_counts[sorted_ranks[0]] == 1)

    [7] + sorted_ranks
  end


end