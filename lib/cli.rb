#!/usr/bin/ruby



require "json"

require_relative "./cube.rb"
require_relative "./util.rb"

class Cube::CLI
    # def initialize(draft)
    #     @draft=draft
    # end
        
    def call
        
        puts "Welcome to the draft table, wizard"
        puts "To shuffle up the cube, enter 'shuffle!'"
        puts "To generate this sessions cube, enter 'generate_cube'."
        puts "To get a pack enter, 'generate_pack'."
        puts "To pass your current hand eneter 'pass_hand'"
        puts "To quit, type 'exit'."
        puts "What would you like to do?"
        input=gets.strip.downcase
        while input!="exit" do
            case input
            when "shuffle!"
                shuffle!
            when "generate_cube"
                generate_cube
            when "generate_pack"
                generate_pack
            when "pass_hand"
                pass_hand
            end
            input=gets
        end
    end

    def shuffle!(n=7)
        n.times { @cards.shuffle! }
    end

    def generate_cube(number=90)
        cards.sample(number)
        cards.sample(number) == draft_set
        draft_set
    end

    def menu
        puts "Choose a card from the pack and enter 'pass_hand' when you're done choosing."
    end

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
    

