extends Node

func Execute(position: Square):
	var searchResult = _searchSameLinealColor(position)
	return _getLinealCombinations(searchResult,position)

func _searchSameLinealColor(position: Square):
	var searchResult = [[],[],[],[]]
	if position == null:
		return searchResult
	for d in DirectionsService.getAllDirections():
		searchResult[d] = _colorCoincidence(position.getRelation(d), position.getColor(), d)
	return searchResult

func _colorCoincidence(position:Square, color: int, direction: int):
	var returndata = []
	if position is Square && position.getColor() == color:
		returndata.append(position)
		returndata += _colorCoincidence(position.getRelation(direction),color,direction)
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

