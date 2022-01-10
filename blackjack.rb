require_relative 'card.rb'
require_relative 'deck.rb'
require_relative 'hand.rb'
require_relative 'account.rb'
require_relative 'player.rb'
require_relative 'dealer.rb'
require_relative 'interface.rb'

class BlackJack
  MENU_METHODS = { 1 => :pass,\
                   2 => :add_card,\
                   3 => :open_cards }.freeze

  def initialize
    @interface = Interface.new
    @dealer = Dealer.new('Дилер')
    @game_account = Account.new
    @deck = Deck.new
    @player = Player.new(@interface.player_setup)
  end

  def start
    deck_replacement if deck_empty?
    deal_initial_cards
    make_bets
    player_turn
  end

  private

  def deck_empty?
    true if @deck.cards.count < 6
  end

  def deck_replacement
    @deck = Deck.new
  end

  def deal_initial_cards
    2.times { @player.hand.take_card_from_deck(@deck) }
    2.times { @dealer.hand.take_card_from_deck(@deck) }
  end

  def make_bets
    @player.account.transfer_to(@game_account, 10)
    @dealer.account.transfer_to(@game_account, 10)
  end

  def hud
    @interface.bank(@game_account.amount)
    @interface.turn(@player.name, @player.account.amount, show_hand(@player), show_hand_value(@player))
    @interface.turn(@dealer.name, @dealer.account.amount, show_hand(@dealer), show_hand_value(@dealer))
  end

  def show_hand(player)
    cards = player.hand.cards_with_suit
    cards.each_with_object([]) do |card, hand|
      card = '*' if player.name == 'Дилер' && @open.nil?
      hand << card
    end
  end

  def show_hand_value(player)
    return if player.name == 'Дилер' && @open.nil?

    player.hand.value
  end

  def player_turn
    open_cards?
    hud
    menu
    choice = @interface.get
    send(MENU_METHODS[choice])
  end

  def menu
    @interface.blackjack_menu(@player.hand.cards.count)
  end

  def pass
    dealer_turn
  end

  def dealer_turn
    @dealer.decide(@deck)
    player_turn
  end

  def add_card
    @player.hand.take_card_from_deck(@deck) if @player.hand.cards.count == 2
    dealer_turn
  end

  def open_cards
    @open = true
    hud
    reward_the_winner
    try_again?
  end

  def open_cards?
    open_cards if @player.hand.cards.count == 3 && @dealer.hand.cards.count == 3
  end

  def who_win?
    return if @player.hand.value == @dealer.hand.value

    winner
  end

  def winner
    if (@player.hand.value <= 21 && @player.hand.value > @dealer.hand.value) ||
       (@dealer.hand.value > 21 && @player.hand.value <= 21)
      @player
    elsif @dealer.hand.value <= 21
      @dealer
    end
  end

  def reward_the_winner
    if who_win?.nil?
      money_back
    else
      @interface.win(who_win?.name)
      @game_account.transfer_to(who_win?.account, @game_account.amount)
    end
  end

  def money_back
    @interface.draw
    @game_account.transfer_to(@player.account, @game_account.amount / 2)
    @game_account.transfer_to(@dealer.account, @game_account.amount)
  end

  def try_again?
    @interface.choice
    choice = @interface.get
    case choice
    when 1
      hands_clear
      @open = nil
      start
    when 2
      @interface.goodbye
      return
    end
  end

  def hands_clear
    @player.hand.drop_cards
    @dealer.hand.drop_cards
  end
end
