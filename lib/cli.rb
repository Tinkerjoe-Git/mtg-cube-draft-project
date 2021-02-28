require 'pry'
class Cube::CLI

    def initialize
        
        Cube::API.new.get_card_data
        Cube::Player.new
        puts "Fetching Card data...."
    end

    def display_cards
        Cube::Card.all.each.with_index(1) do |card, index|
            puts "#{index}. #{card.name}."
        end
    end

    def card_lookup!
        # 1. Show them all the cards
        display_cards

        # 2. Get which card number they want to lookup
        input=gets.chomp.downcase

        # 3. Lookup the card
        index = input.to_i - 1
        card = Cube::Card.all[index]

        # 4. Show them the card
        puts "Text: #{card.text}"
        puts "Type: #{card.types}"
        puts "Cmc: #{card.cmc}"

        if card.colors == ["Red"]
            puts "Colors: #{card.colors} ".colorize(:red)
        elsif card.colors == ["Green"]
            puts "Colors: #{card.colors} ".colorize(:green)
        elsif card.colors == ["White"]
            puts "Colors: #{card.colors} ".colorize(:white)
        elsif card.colors == ["Blue"]
            puts "Colors: #{card.colors} ".colorize(:blue)
        elsif card.colors == ["Black"]
            puts "Colors: #{card.colors} ".colorize(:black).colorize(:background => :white)
        elsif card.colors == []
            puts "Colors: #{card.colors} ".colorize(:brown).colorize(:background => :grey)
            puts "Colorless"
        else 
            puts "Colors: #{card.colors} ".colorize(:light_blue).colorize(:background => :black)
            puts "Multicolored"
        end

        puts "----------------------------".colorize(:red)
    end

    def start
        input = ""
        while input!="exit" do
            # 1. Show user their options.
            puts "Welcome to the table Wizard, lets draft!"
            puts "To shuffle up the cube, enter 'shuffle'"
            puts "To generate this sessions cube, enter 'generate cube'."
            puts "To get a pack enter, 'generate pack'."
            ## a new menu for players hands, ask user which card they would like to add to their library
            ## present player with a menu of options, pass card, look at library array, receive the next hand?
            puts "To pass your current hand enter 'pass hand'"
            puts "To look at your current library of cards enter, 'library'"
            puts "To lookup a specific card enter, 'lookup card'"
            puts "To quit, type 'exit'."
            puts "What would you like to do?"

            # 2. Get input from user.
            input=gets.strip.downcase

            # 3. Perform chosen option.
            case input
            when "shuffle"
                shuffle!
            when "generate cube"
                generate_cube
            when "generate pack"
                generate_pack
            when "pass hand"
                pass_hand
            when "library"
                look_at_library
            when "lookup card"
                card_lookup!
            end
        end
    end

    def look_at_library
        @player.library
    end

    def shuffle!(n=7)
        @cards = display_cards

        n.times { @cards.shuffle! }
            ## no return statement on shuffle method currently 
        puts "All shuffled up #{n} times."
    end

    def generate_players(count)
        players = []

        count.times do
            players << Cube::Player.new
        end
        
        players
    end

    def loop_back
        puts "Please input 'y' to go to the Draft Menu or 'n' to return, enter 'exit' to close the application."
        answer = gets.chomp
        case answer
        when "y"
            menu
        when "n"
            ## Figure out if you want to expand upon this, or is it fine
            puts "Alright then, what do you want to do"
        else
            start
        end
    end
            


    def pass_hand(players)
        # current player's hand is given to previous player
        # that means that the first player will give their hand to the last player
        # that means that once we get to the last player, their hand is already gone...

        # gather all of the hands, in order, into an array
        hands = players.map { |player| player.hand }

        # we loop over the players (with index)
        players.each_with_index do |player, index|
            # we want to pass the cards to the previous person
            next_index = index - 1

            # if the previous person is last, we need to account for that
            if next_index < 0
                next_index = players.size - 1
            end

            # because we already set the hands aside in the `hands` array, we can grab them and reassign the player's hands without worrying about losing anything
            player.hand = hands[next_index]
        end
    end

    def generate_cube
        number_of_rounds = 3
        number_of_players = 2
        number_of_cards_per_player_per_round = 15

        # take (15 * number of rounds * number of players) cards from array of all 540 cards to make session's cube
        deck_for_session = @cards.sample(number_of_cards_per_player_per_round * number_of_rounds * number_of_players)
        puts "Cube successfully generated, lets begin."
        # all players take 15 cards from the top
        players = generate_players(number_of_players)

        number_of_rounds.times do

            players.each do |player|

                player.put_cards_in_hand(number_of_cards_per_player_per_round, deck_for_session)
                number_of_rounds -= 1
                if number_of_rounds == 0
                    puts "The draft session is complete, go on and create your limited deck or we can draft again!"
                    loop_back
                end


            end

            # keep doing that until all cards are taken
            number_of_cards_per_player_per_round.times do
                # all players have their cards
                players.each do |player|
                    # look at cards, chose one that they want
                    player.choose_one_card_from_hand
                end

                # card they chose goes into a library, 14 remaining cards get passed to next player
                pass_hand(players)
                puts "You've passed the hand, here comes the next one."
            end
        end

        players.each do |player|
            puts @player.name
            puts @player.library
        end

        def user_input
            @input = gets.chomp.downcase
            if input == "exit"
                exit
            elsif @input == "menu"
                start
            end
            @input
        end



    end
end

