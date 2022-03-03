extends Node

func Execute(position: Square):
	var searchResult = _searchSameLinealColor(position)
	return _getLinealCombinations(searchResult,position)

func _searchSameLinealColor(position: Square):
	var searchResult = [[],[],[],[]]
	for d in Directions.allDirections:
		var nextPosition = position.adyacencies[d]
		if nextPosition is Square:
			searchResult[d] = _colorCoincidence(position.adyacencies[d], position.color, d)
	return searchResult

func _colorCoincidence(position:Square, color: int, direction: int):
	var returndata = []
	if position is Square && position.color == color:
		returndata.append(position)
		returndata += _colorCoincidence(position.adyacencies[direction],color,direction)
	return returndata
	
func _getLinealCombinations(searchResult, position):
	var vertical = searchResult[0] + searchResult[2]
	var horizontal = searchResult[1] + searchResult[3]
	var combinations = []
	if(vertical.size() >= 2):
		combinations.append(Combination.new(position, vertical))
	if(horizontal.size() >= 2):
		combinations.append(Combination.new(position, horizontal))
	return combinations

