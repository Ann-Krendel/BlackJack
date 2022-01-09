class Account
  def initialize(amount = 0)
    @amount = amount
  end
  
  attr_accessor :amount
  
  def transfer_to(account, amount)
    raise 'Не достаточно денег на счете' if amount > @amount
  
    @amount -= amount
    account.amount += amount
  end
end