module Cube
    class API

        def initialize
            @url = "https://api.magicthegathering.io/v1/cards"
        end

        def get_card_data
            response_hash = HTTParty.get(@url)
            binding.pry
        end

    end
end