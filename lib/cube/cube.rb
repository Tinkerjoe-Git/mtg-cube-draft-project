

require "mtg_sdk"
require "json"


module Cube
	attr_reader :cardnames

	def self.cardnames()

		filename = "data/cube.txt"

		if not File.file?(filename)

			if not Dir.exist?("data/")
				Dir.mkdir("data/")
			end

			cardnames = ["Yoked Ox", "Inspired Charge", "Scroll Thief",
				"Divination", "Ravenous Rats", "Disentomb", "Furnace Whelp",
				"Lightning Strike", "Centaur Courser", "Rampant Growth"]

			File.open(filename, "w") do |f|
				f.puts(cardnames)
			end

			return cardnames
		end

		cardnames = []

		
		File.open(filename).each do |line|
			line.strip!
			if line.empty?
				next
			end
			if line.start_with?("//")
				next
			end
			cardnames << line
		end

		return cardnames
	end

	def self.cards()

		cards = []

		cardnames().each do |cardname|

			filename = "cache/" + cardname + ".json"

			if File.file?(filename)
				File.open(filename).each do |line|
					cards << JSON.parse(line)
				end
				next
			end

			if not Dir.exist?("cache/")
				Dir.mkdir("cache/")
			end

			print "Fetching #{cardname}... \t"

			if !cardname.include?("'")
				cardname = "\"#{cardname}\""
			end

			results = MTG::Card
					.where(name: "#{cardname}")
					.where(pageSize: 1)
					.all

			fail if results.nil? || results.empty?


			card = results[0]

			File.open(filename, 'w') do |line|
				line.puts card.to_json
			end

			print "Successfully pulled from API\n"

			cards << JSON.parse(card.to_json)
		end

		return cards
	end

	# def generate_packs(set, format)
	# 	packs = []
	# 	Card.uncached do
	# 	  if format == "draft"
	# 		24.times {packs.push(generate_booster(set))}
	# 	  else
	# 		6.times {packs.concat(generate_booster(set))}
	# 	  end
	# 	end
	# 	packs
	# end
	
	# def generate_booster(set)
	# 	pack = []
	# 	num = rand(1..8)
	
	# 	if num === 1
	# 	  rare = Card.joins(:set).where(sets: { code: set }).where(rarity: "Mythic").order("RAND()").limit(1)
	# 	else
	# 	  rare = Card.joins(:set).where(sets: { code: set }).where(rarity: "Rare").order("RAND()").limit(1)
	# 	end
	
	# 	uncommon = Card.joins(:set).where(sets: { code: set }).where(rarity: "Uncommon").order("RAND()").limit(3)
	# 	common = Card.joins(:set).where(sets: { code: set }).where(rarity: "Common").where.not("cards.name LIKE ?", "%Guildgate%").order("RAND()").limit(10)
	# 	land = Card.joins(:set).where(sets: { code: set }).where("cards.name LIKE ?", "%Guildgate%").order("RAND()").limit(1)
	
	# 	pack.concat(rare, uncommon, common, land)
	# end

end