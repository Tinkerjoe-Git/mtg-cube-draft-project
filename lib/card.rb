class Cube::Card

    @@all=[]

    ## Class method that takes in an arg, filters through display cards and gives back all the card objects of the specific type.
    
    def initialize(card_hash)
        card_hash.each do |key, value|
            self.class.attr_accessor(key)
            self.send("#{key}=", value)
        end
        @@all << self
    end

    def self.all
        @@all
    end

    ## iterate through the cards with a select potentially and find out results 'true'
    ## whats our type? creature or something.
    ## return those creatures
    ## args need to look like ["Creature"] ["Instant"] ["Sorcery"] ["Land"] ["Artifact"] ["Enchantment"]
    ## some cards have multiple types, not every randomized 'cube' collection will absolutely have every type
    ## but it almost always does, the corner cases are super rare.
    def self.find_card_type(types)
        @@all.select {|card| card.types==types}
    end




  

end
    