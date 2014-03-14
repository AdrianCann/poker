require 'card'
require 'deck'

describe Deck do

  describe "::generate_cards" do
    subject(:cards)  { cards = Deck.generate_cards }
    it "should generate a card array of length 52" do
      expect(cards.count).to eq(52)
    end

    it "should generate no duplicates" do
      expect(cards.uniq.count).to eq(52)
    end

  end

  describe "#deal" do
    let(:cards) { cards = [Card.new(:clubs, :deuce),
      Card.new(:hearts, :deuce),
      Card.new(:clubs, :ace),
      Card.new(:clubs, :king),
      Card.new(:clubs, :queen),
      Card.new(:diamonds, :deuce)]
    }

    subject(:deck) { Deck.new(cards)}

    it "should take the top 5 cards" do
      expected_cards = [Card.new(:clubs, :deuce),
      Card.new(:hearts, :deuce),
      Card.new(:clubs, :ace),
      Card.new(:clubs, :king),
      Card.new(:clubs, :queen)]

      expect(deck.deal(5)).to eq(expected_cards)

    end

    it "should remove the dealt cards from the deck" do

      deck.deal(5)

      expect(deck.cards.count).to eq(1)
    end

  end

  describe "#shuffle_cards" do
    let(:cards)  { cards = Deck.generate_cards }
    subject(:deck) { Deck.new(cards)}

    let!(:duped_cards) {duped_cards = cards.dup}
    let!(:other_deck) { Deck.new(duped_cards)}


    it "changes the internal set of cards" do

      deck.shuffle_cards

      expect(deck.cards).to_not eq(duped_cards)
    end

    it "it does not shuffle in the same way with each shuffle" do

      deck.shuffle_cards
      other_deck.shuffle_cards

      expect(deck.cards).to_not eq(other_deck.cards)
    end

  end


end