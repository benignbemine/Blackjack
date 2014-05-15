#/////////// Classes and Methods ////////////////////
def say(msg)
  puts "
  >>>> #{msg} <<<<
  "
end

class Player
  def initialize(player="Computer")
    @info={name:player, cards: []}
  end

  def info
    @info #why did i need to initialize this? getter method??
  end

  def show_cards

    info[:cards].each do |a|
      puts "You currently have the #{a[1]} of #{a[0]}"
    end
  end
end

class Deck
  def initialize
    suits = ['Spades', 'Hearts', 'Diamonds', 'Clubs']
    values = [
          ['Ace',11], ['King',10], ['Queen',10], ['Jack',10],
          [10], [9], [8], [7], [6], [5], [4], [3], [2]
        ]
    @cards = suits.product(values).shuffle
  end

  def cards
    @cards
  end

  def deal
    cards.pop.flatten
  end

end


#/////////// StartUp ////////////////////

puts "------------ Hi! Lets play BlackJack! ------------"

say("Please enter your name")
gambler = Player.new(gets.chomp)
computer=Player.new

say("Hi #{gambler.info[:name]}! I hope you're ready to lose some money. I'm dealing")

#/////////// GamePlay ////////////////////

live_deck = Deck.new
gambler.info[:cards]<<live_deck.deal
computer.info[:cards]<<live_deck.deal
gambler.info[:cards]<<live_deck.deal
computer.info[:cards]<<live_deck.deal

gambler.show_cards






