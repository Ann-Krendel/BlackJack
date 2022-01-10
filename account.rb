class Account
  attr_accessor :amount

  def initialize(amount = 0)
    @amount = amount
  end

  def transfer_to(account, amount)
    raise 'Не достаточно денег на счете' if amount > @amount

    @amount -= amount
    account.amount += amount
  end
end
