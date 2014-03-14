# -*- coding: utf-8 -*-

class Card

  SUIT_STRINGS = {
    :clubs    => "♣",
    :diamonds => "♦",
    :hearts   => "♥",
    :spades   => "♠"
  }

  POKER_VALUE = {
    :deuce => 2,
    :three => 3,
    :four  => 4,
    :five  => 5,
    :six   => 6,
    :seven => 7,
    :eight => 8,
    :nine  => 9,
    :ten   => 10,
    :jack  => 11,
    :queen => 12,
    :king  => 13,
    :ace   => 14
  }

  def self.suits
    SUIT_STRINGS.keys
  end

  def self.values
    POKER_VALUE.keys
  end

  attr_reader :suit, :rank

  def initialize(suit, rank)
    @suit = suit
    @rank = rank
  end

  def val
    POKER_VALUE[rank]
  end

  def inspect
    [suit, rank].inspect
  end

  def to_s
    POKER_VALUE[value].to_s + SUIT_STRINGS[suit]
  end

  def == (other_card)
    (self.suit == other_card.suit) && (self.rank == other_card.rank)
  end

end