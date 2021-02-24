#!/usr/bin/ruby

require "mtg_sdk"
require "json"


module Cube

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

		# TODO Optimize with File.foreach?
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

			print "Downloading #{cardname}... \t"

			if !cardname.include?("'")
				cardname = "\"#{cardname}\""
			end

			results = MTG::Card
					.where(name: "#{cardname}")
					.where(pageSize: 1)
					.all

			fail if results.nil? || results.empty?

			# TODO Choose which result to take.
			card = results[0]

			File.open(filename, 'w') do |line|
				line.puts card.to_json
			end

			print "OK\n"

			cards << JSON.parse(card.to_json)
		end

		return cards
	end

end