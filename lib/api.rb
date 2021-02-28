# require 'pry'
# require 'mtg_sdk'
class Cube::API



    def initialize
        @url = "https://api.magicthegathering.io/v1/cards"
    end


    def get_card_data
        card_hash = HTTParty.get(@url)
        card_array = card_hash["cards"]
        self.create_card_objects(card_array)
    end

    def create_card_objects(card_array)
        card_array.each do |card_hash|
            Cube::Card.new(card_hash)
        end
    end
end

