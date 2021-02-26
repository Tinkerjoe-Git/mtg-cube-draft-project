# require 'pry'
# require 'mtg_sdk'
class Cube::API


    # def initialize
    #     @cards = Cube::API.new.create_card_objects
    # end


    def initialize
        @url = "https://api.magicthegathering.io/v1/cards"
    end


    ##Potentially lets just get this from the sdk, things aren't operating well, check out scryfall api or mtg_sdk api for another way.

    def get_card_data
        card_hash = HTTParty.get("https://api.magicthegathering.io/v1/cards")
        card_array = card_hash["cards"]
        self.create_card_objects(card_array)
        
    end



    def create_card_objects(card_array)
        card_array.each do |card_hash|
            Cube::Card.new(card_hash)
        end
    end
end

#     def self.card_names
#         filename = "data/cube.txt"

#         card_names = []


#         File.open(filename).each do |line|
#             line.strip!
#             if line.empty?
#                 next
#             end
#             if line.start_with?("//")
#                 next
#             end
#             card_names << line
#         end

#         card_names
#     end




#     def self.create_card_objects
#         cards = []
#         card_names.each do |card_name|
#             print "Downloading #{cardname}... \t"


#             if !cardname.include?("'")
#                 cardname = "\"#{cardname}\""
#             end
    
#             results = MTG::Card
#                     .where(name: "#{cardname}")
#                     .where(pageSize: 1)
#                     .all
#             card = results[0]

            
#             card.each do |card|
#                 Cube::Card.new(card_hash)
#             end
#             print "Card object created\n"

#             cards << card["data"]
#         end
#         return cards
#     end
# end
