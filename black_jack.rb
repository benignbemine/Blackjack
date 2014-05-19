#/////////// Classes and Methods ////////////////////
def say(msg)
  puts "
  >>> #{msg} <<<
  "
end

class Card

  def initialize(name, suit, value)
    @name=name
    @suit=suit
    @value=value
  end

  def name
    @name
  end

  def value
    @value
  end

  def value=(a)
    @value = a
  end

  def suit
    @suit
  end

end

class Deck

  def initialize
    @cards = []
    suits = ['Spades', 'Hearts', 'Diamonds', 'Clubs']
    values_names = [['Ace',11], ['King',10], ['Queen',10], ['Jack',10],
       [10], [9], [8], [7], [6], [5], [4], [3], [2]]
    suits.each do |suit|
      values_names.each do |vals|
        @cards.push(Card.new(vals[0], suit, vals.last))
      end
    end
    @cards = @cards.shuffle
  end
#############
  def cards
    @cards
  end

end

class Player

  def initialize(player="The Computer")
    @info={name:player, cards: []}
  end
########
  def info
    @info
  end
########
  def value
    value = 0
    @info[:cards].each do |a|
      value += a.value.to_i
    end
    return value
  end
##########
  def show_player_cards
    @info[:cards].each do |a|
      puts "#{info[:name]} currently holds the #{a.name} of #{a.suit}"
    end
  end
##########
  def show_dealer_cards
    @info[:cards].each_with_index do |a, index|
      if index == 0
        next
      end
      puts "The #{info[:name]} currently holds the #{a.name} of #{a.suit}"
    end
  end
###########
  def ace_count
    count = 0
    @info[:cards].each do |a|
      if a.name == 'Ace'
        count+=1
      end
    end
    return count
  end
############
  def ace_to_one
    @info[:cards].each do |a|
      if (a.name == 'Ace' && a.value == 11)
        a.value=(1)
        break
      end
    end
  end
#############
  def dealing_with_aces
    i = 0
    until i == ace_count
      say("You have an Ace so you can re-choose the value! Would you like to value it as an 11 or as a 1? Type an '11' or '1'")
      while ace = gets.chomp
        if ace == "11"
          i+=1
          break
        elsif ace == "1"
          ace_to_one
          i+=1
          break
        else
          say("C'mon #{info[:name]}! Invalid Response: Please choose '11' or '1'")
        end
      end
    end
  end
##########
end

#/////////// StartUp ////////////////////

puts "------Hi! Lets play BlackJack!------"
say("Please enter your name")
gambler = Player.new(gets.chomp)
computer = Player.new

say("Hi #{gambler.info[:name]}! I hope you're ready to lose some money. I'm dealing! Lets see the cards:")

# #/////////// GamePlay ////////////////////

live_deck = Deck.new
gambler.info[:cards]<<live_deck.cards.pop
computer.info[:cards]<<live_deck.cards.pop
gambler.info[:cards]<<live_deck.cards.pop
computer.info[:cards]<<live_deck.cards.pop
gambler.show_player_cards
computer.show_dealer_cards
gambler.dealing_with_aces
# #//////////////Player Interaction ///////////////
gambler_bust = false
computer_bust = false

say("Would you like to Hit or Stay? Type 'H' or 'S' until you have finalized your hand!")
while hit = gets.chomp
  if hit == "H" || hit == "h"
    gambler.info[:cards]<<live_deck.cards.pop
    gambler.show_player_cards
    gambler.dealing_with_aces
    if gambler.value>21
      gambler_bust = true
      break
    elsif gambler.value<21
      say("Hit Again????? #{gambler.info[:name]}, you prolly should. Type 'H' or 'S'")
    end
  elsif hit == "S" || hit == "s"
    break
  else
    say("C'mon #{gambler.info[:name]}! Invalid Response: Please choose 'H' or 'S'")
  end
end

#//////// After the player hits. ///////////

if gambler_bust == false
  while computer.value < 17
    computer.info[:cards]<<live_deck.cards.pop
    if computer.value > 21
      computer_bust = true
    end
  end
  if computer_bust == false
    computer.show_player_cards
    if gambler.value > computer.value
      puts("----You have #{gambler.value}, The Computer has #{computer.value}----")
      say("YOU WIN!!!!!!!!!!!!!! You win nothing because I haven't added betting functionality to this program.")
    else
      puts("----You have #{gambler.value}, The Computer has #{computer.value}----")
      say("You LOSSSSSEEEEEEEEEEEEEE")
    end
  else
    puts("----You have #{gambler.value}, The Computer has #{computer.value}----")
    say("The Computer Busted, You WINNNNNNNNNNN")
  end
else
  puts("----You have #{gambler.value}, The Computer has #{computer.value}----")
  say("Nice job #{gambler.info[:name]}, YOU BUSTED! I'm not surprised")
end







