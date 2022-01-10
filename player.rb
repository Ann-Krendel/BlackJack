class Player
  attr_reader :name, :hand, :account

  INITIAL_AMOUNT = 100

  def initialize(name)
    @name = name
    @hand = Hand.new
    @account = Account.new(INITIAL_AMOUNT)
  end
end
