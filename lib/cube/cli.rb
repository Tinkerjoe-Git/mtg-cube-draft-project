



require "json"


# require_relative "./cube.rb"

module Cube

    class Card
        attr_reader :name, :cmc, :power, :toughness
    end

    class CLI
            
        def start

            @cards = Cube.cards()
            
            puts "Welcome to the draft table, wizard"
            input=""
            while input!="exit" do
                puts "To shuffle up the cube, enter 'shuffle!'"
                puts "To generate this sessions cube, enter 'generate_cube'."
                puts "To get a pack enter, 'generate_pack'."
                puts "To pass your current hand eneter 'pass_hand'"
                puts "To quit, type 'exit'."
                puts "What would you like to do?"
                input=gets.strip.downcase
                case input
                when "shuffle"
                    shuffle!
                when "generate cube"
                    generate_cube
                when "generate pack"
                    generate_pack
                when "pass hand"
                    pass_hand
                end

            end

        end

        def shuffle!(n=7)

            n.times { @cards.shuffle! }

            puts "All shuffled up #{n} times."
        end

        def generate_cube(number=90)
            @cards.sample(number)
        end

        # def menu
        #     puts "Choose a card from the pack and enter 'pass_hand' when you're done choosing."
        # end

        def list_pack_contents
            packs.sorted
            packed.each.with_index(1) {|card, index|}
        end


        # def generate_packs(block, format)
        #     packs = []
        #     Card.uncached do
        #         if format == "draft"
        #         24.times {packs.push(generate_booster(block))}
        #         else
        #         6.times {packs.concat(generate_booster(block))}
        #         end
        #     end
        #     packs
        # end

    end
end
    

