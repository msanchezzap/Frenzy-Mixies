class_name BasicSearch extends Node

var combinationAlg = []
func _init():
	combinationAlg = [LinealCombinationAlgorithm.new(), SquareCombinationAlgorithm.new()]
	
func Execute(position: SquareComponent):
	var combinations = []
	combinations = _getCoincidence(position,position.getColor())
	return combinations
	
func _getCoincidence(position: SquareComponent, color: int):
	var searchResult = [[],[],[],[]]
	for d in DirectionsService.getAllDirections():
		searchResult[d] = _getColorCoincidenceByDirection(position.getRelation(d), color, d)
	var combinations = []
	for alg in combinationAlg:
		combinations += alg.Execute(searchResult,position)
	return combinations

func _getColorCoincidenceByDirection(position:Square, color: int, direction: int):
	var returndata = []
	if position is Square && (position.getColor() == color || position.getColor() == Colors.JOKER):
		returndata.append(position)
		returndata += _getColorCoincidenceByDirection(position.getRelation(direction),color,direction)
	return returndata
