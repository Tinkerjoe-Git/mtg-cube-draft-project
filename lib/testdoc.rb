#!/usr/bin/ruby


require "json"

require "./cube.rb"
require "./util.rb"

colors = ARGV

cards = Cube::cards()

effects = {}
effects.default_proc = proc {0}
keywords = {}
keywords.default_proc = proc {0}
abilitywords = {}
abilitywords.default_proc = proc {0}
costs = {}
costs.default_proc = proc {0}

cards.each do |card|
	if colors.any? && (colorfix(card['colors']) & colors).empty?
		next
	end
	text = card['text']
	if text.nil?
		next
	end
	text.gsub!(card['name'], "~")
	text.gsub!(/[ ]+\(.*?\)/, "")
	lines = text.split("\n")
	lines.map{|line|
		subs = line.scan(/\"(.*?)\"/)
		subs.each do |sub|
			lines << sub.join()
		end
	}
	lines.map{|line| line.gsub!(/\".*?\.\"/, "\"\"\.")}
	lines.map{|line| line.gsub!(/\".*?\"/, "\"\"")}
	lines.each do |line|
		(line, head) = line.split(" — ").reverse
		if not head.nil?
			abilitywords[head.capitalize] += 1
		end
		(line, head) = line.split(": ").reverse
		if not head.nil?
			head.split(", ").each do |cost|
				costs[cost.capitalize] += 1
			end
		end
		if line[-1] != "." and line[-2] != "."
			line.split(", ").each do |keyword|
				(costedkeyword, cost) = line.split(" ")
				if not cost.nil? and cost[0] == "{"
					keywords[costedkeyword.capitalize] += 1
					costs[cost.capitalize] += 1
				elsif not cost.nil? and cost.sub(/[0-9]+/,"") == ""
					keywords[costedkeyword.capitalize] += 1
				else
					keywords[keyword.capitalize] += 1
				end
			end
		else
			parts = [line]
			parts = parts.map{|part| part.split(". ")}.flatten(1)
			parts = parts.map{|part|
				if part.include?(", or")
					[part]
				else
					part.split(", ")
				end
			}.flatten(1)
			parts = parts.map{|part| part.sub(".","")}
			parts = parts.map{|part| part.sub(/then /i,"")}
			parts.each do |part|
				effects[part.capitalize] += 1
			end
		end
	end
end

puts "\nKeywords"
keywords = keywords.sort_by{|key, value| value}.reverse
keywords.each do |key, value|
	puts "#{value}x \t#{key}"
end

puts "\nAbilitywords"
abilitywords = abilitywords.sort_by{|key, value| value}.reverse
abilitywords.each do |key, value|
	puts "#{value}x \t#{key}"
end

puts "\nCosts"
costs = costs.sort_by{|key, value| value}.reverse
costs.each do |key, value|
	puts "#{value}x \t#{key}"
end

puts "\nEffects"
effects = effects.sort_by{|key, value| value}.reverse
effects.each do |key, value|
	puts "#{value}x \t#{key}"
end