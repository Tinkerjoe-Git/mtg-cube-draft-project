

class Cube::Card

    @@all=[]
    
    def initialize(card_hash)
        card_hash["attributes"].each do |key, value|
            self.class.attr_accessor(key)
            self.send("#{key}=", value)
        end
        @@all << self
    end

    def self.all
        @@all
    end

    def get_card_name
        self.all.each do |card|
            puts "#{card.name} , #{card.colors}"
        end
    end

    def get_card_cmc(name)
        Card.name do |card|
            puts "#{card.cmc}"
        end
    end

    def get_card_colors(name)
        Card.name do |card|
            puts "#{card.colors}"
        end
    end

end
    