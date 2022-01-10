class Hand
  attr_reader :cards

  def take_card_from_deck(deck)
    raise 'В колоде закончились карты' if deck.cards.empty?

    @cards ||= []
    @cards << deck.cards.shift
  end

  def cards_with_suit
    @cards.each_with_object([]) do |card, cards|
      cards << "#{card.value}#{card.suit}"
    end
  end

  def value
    total = 0
    ace_count = 0
    @cards.each do |card|
      total += card.value if card.value.is_a? Integer
      total += 10 if card.value.is_a? String
      total += 1 if card.value == 'A'
      ace_count += 1 if card.value == 'A'
    end
    total -= 10 if total > 21 && ace_count.positive?
    total
  end

  def drop_cards
    @cards.clear
  end
end
