require 'hand'
require 'deck'

describe Hand do

  describe "#initialize" do
    let!(:deck) { deck = Deck.new }
    let!(:cards) { cards = deck.deal(5)}
    subject(:hand) { hand  = Hand.new(cards) }


    it "initializes a hand from an array of dealt cards" do
      expect(hand.cards).to eq(cards)
    end
  end

  describe "#get_cards" do

    let!(:cards) { cards = [Card.new(:clubs, :deuce),
      Card.new(:hearts, :deuce),
      Card.new(:clubs, :ace)]
    }
    subject(:hand) { hand  = Hand.new(cards) }

    it "puts new cards into its array of held cards" do
      new_cards = [ Card.new(:clubs, :queen),
      Card.new(:diamonds, :deuce)]

      hand.get_cards(new_cards)

      expect(hand.cards).to eq(cards + new_cards)
    end
  end

  describe "#discard" do
    let!(:cards) { cards = [Card.new(:clubs, :deuce),
      Card.new(:hearts, :deuce),
      Card.new(:clubs, :ace),
      Card.new(:clubs, :queen),
      Card.new(:diamonds, :deuce)]
    }
    subject(:hand) { hand  = Hand.new(cards) }

    it "removes the proper cards from its own card array" do
      discard_cards = [Card.new(:clubs, :ace),
      Card.new(:clubs, :queen)]

      proper_remain_cards = [Card.new(:clubs, :deuce),
      Card.new(:hearts, :deuce),
      Card.new(:diamonds, :deuce)]

      hand.discard(discard_cards)

      expect(hand.cards).to eq(proper_remain_cards)
    end

  end

  describe "#hand_value" do

    context "correctly identifies each of the nine types of hand" do

      let! (:cA) { cA = Card.new(:clubs, :ace) }
      let! (:cK) { cK = Card.new(:clubs, :king) }
      let! (:cQ) { cQ = Card.new(:clubs, :queen) }
      let! (:cJ) { cJ = Card.new(:clubs, :jack) }
      let! (:cT) { cT = Card.new(:clubs, :ten) }
      let! (:c5) { c5 = Card.new(:clubs, :five) }
      let! (:dQ) { dQ = Card.new(:diamonds, :queen) }
      let! (:h5) { h5 = Card.new(:hearts, :five) }
      let! (:s5) { s5 = Card.new(:spades, :five) }
      let! (:d5) { d5 = Card.new(:diamonds, :five) }


      let! (:no_hand) { no_hand  = Hand.new([cA, cK, cT, dQ, s5]) }
      let! (:one_pr) { one_pr  = Hand.new([cA, cT, cQ, dQ, d5]) }
      let! (:two_pr) { two_pr  = Hand.new([d5, s5, cQ, cK, dQ]) }
      let! (:trips) { trips  = Hand.new([d5, dQ, c5, cA, s5]) }
      let! (:strt) { strt  = Hand.new([cT, cA, dQ, cK, cJ]) }
      let! (:fls) { fls  = Hand.new([c5, cK, cQ, cA, cJ]) }
      let! (:boat) { boat  = Hand.new([cQ, s5, d5, c5, dQ]) }
      let! (:quads) { quads  = Hand.new([d5, s5, cQ, c5, h5]) }
      let! (:str_fls) { str_fls  = Hand.new([cT, cA, cQ, cK, cJ]) }



      it "recognizes no_pair"  do
        expect(no_hand.hand_value).to eq(:no_pair)
      end

      it "recognizes pair" do
        expect(one_pr.hand_value).to eq(:pair)
      end

      it "recognizes two_pair" do
        expect(two_pr.hand_value).to eq(:two_pair)
      end

      it "recognizes three_of_a_kind" do
        expect(trips.hand_value).to eq(:three_of_a_kind)
      end

      it "recognizes straight" do
        expect(strt.hand_value).to eq(:straight)
      end

      it "recognizes flush" do
        expect(fls.hand_value).to eq(:flush)
      end

      it "recognizes full_house" do
        expect(boat.hand_value).to eq(:full_house)
      end

      it "recognizes four_of_a_kind" do
        expect(quads.hand_value).to eq(:four_of_a_kind)
      end

      it "recognizes straight_flush" do
        expect(str_fls.hand_value).to eq(:straight_flush)
      end

    end

  end

end


