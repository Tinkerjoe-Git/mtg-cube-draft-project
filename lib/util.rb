#!/usr/bin/ruby

def colorfix(colors)
	if colors.nil? || colors.empty?
		return ['Colorless']
	end
	if colors.length == 1
		return colors
	end
	canonicals = [
		['White', 'Blue'],
		['Blue', 'Black'],
		['Black', 'Red'],
		['Red', 'Green'],
		['Green', 'White'],
		['White', 'Black'],
		['Blue', 'Red'],
		['Black', 'Green'],
		['Red', 'White'],
		['Green', 'Blue'],
		['Green', 'White', 'Blue'],
		['White', 'Blue', 'Black'],
		['Blue', 'Black', 'Red'],
		['Black', 'Red', 'Green'],
		['Red', 'Green', 'White'],
		['White', 'Black', 'Green'],
		['Blue', 'Red', 'White'],
		['Black', 'Green', 'Blue'],
		['Red', 'White', 'Black'],
		['Green', 'Blue', 'Red'],
		['Blue', 'Black', 'Red', 'Green'],
		['Black', 'Red', 'Green', 'White'],
		['Red', 'Green', 'White', 'Blue'],
		['Green', 'White', 'Blue', 'Black'],
		['White', 'Blue', 'Black', 'Red'],
		['White', 'Blue', 'Black', 'Red', 'Green']
	]
	return canonicals.select{
		|canonical| canonical.sort == colors.sort
	}[0] || colors
end
