require_relative 'card.rb'
require_relative 'deck.rb'
require_relative 'hand.rb'
require_relative 'account.rb'
require_relative 'player.rb'
require_relative 'dealer.rb'

class Interface

  def clear
    system("clear") || system("cls")
  end

  def player_setup
    clear
    puts 'Введите ваше имя:'
    gets.chomp
  end

  def bank(money)
    clear
    puts "В банке: #{money}$"
  end

  def turn(name, amount, hand, hand_value)
    puts "
    -------------
    #{name}: #{amount}$
    Карты #{name}: #{hand}
    Сумма очков: #{hand_value}
    -------------
    "
  end

  def blackjack_menu(player_hand_cards_count)
    puts 'Ваш ход:'
    puts '1. Пропустить'
    puts '2. Добавить карту' if player_hand_cards_count == 2
    puts '3. Открыть карты'
  end

  def win(winner)
    puts "Победитель: #{winner}"
  end

  def draw
    puts 'Ничья, деньги возвращаются игрокам'
  end
  
  def choice
    puts "Хотите сыграть еще раз?\n1. Да\n2. Нет"
  end

  def get
    gets.chomp.to_i
  end

  def goodbye
    puts 'Повезет в следующий раз'
  end
end
