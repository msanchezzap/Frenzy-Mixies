extends Node


func getCombinationDirections(combination: Combination):
	var findedDirections = []
	for d in DirectionsService.getAllDirections():
		if combination.members.has(combination.origin.getRelation(d)):
			findedDirections.append(d)
	return findedDirections
