extends Node

func Execute(origin: Square,findedDirections):
	var totalPotential = SearchAlgorithm.Execute(origin)
	for d in findedDirections:
		totalPotential += _executeDirection(origin.adyacencies[d],d)
	return totalPotential

func _executeDirection(origin:Square, d):
	var potential = []
	if origin != null:
		potential = SearchAlgorithm.Execute(origin)
		potential += _executeDirection(origin.adyacencies[d],d)
	return potential

