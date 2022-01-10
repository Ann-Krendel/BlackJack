class Deck
  attr_reader :cards

  SUITS = ['♠', '♥', '♦', '♣'].freeze
  VALUES = [*(2..10), 'J', 'Q', 'K', 'A'].freeze

  def initialize
    generate
    shuffle
  end

  private

  def generate
    @cards = []
    SUITS.each do |suit|
      VALUES.each { |value| @cards << Card.new(suit, value) }
    end
  end

  def shuffle
    @cards.shuffle!
  end
end
