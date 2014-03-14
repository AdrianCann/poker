require 'card'

describe Card do




  describe "#val" do

    subject(:card)  { card = Card.new(:clubs, :four) }

    it "should return numeric value of the card" do


      expect(card.val).to eq(4)
    end

    it "should return a higher value for ace than the king" do
      #subject(:card_ace)  { card = Card.new(:clubs, :ace) }
      card_ace = Card.new(:clubs, :ace)
      card_king = Card.new(:diamonds, :king)

      expect(card_ace.val).to be > card_king.val
    end

  end

end