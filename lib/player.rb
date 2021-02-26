class Cube::Player
    attr_accessor :hand
    attr_reader :library, :name

    def initialize
        @library = []
        @name = "Player"

    end


    def put_cards_in_hand(count, deck)
        @hand = deck.pop(count)
    end

    def choose_one_card_from_hand

        puts "Enter card number from list:"
        
        @hand.each.with_index(1) do |card, index|
            
            puts "#{index}. #{card["name"]}"
            
        end

        index = gets.strip.to_i - 1

        # remove card at choosen index from hand...
        choosen_card = @hand.slice!(index)

        # ...add it to library
        @library << choosen_card
    end
end