extends Node

func BasicDestruction(combination: Combination):
	var m = combination.members.duplicate()
	for d in CombinationService.getCombinationDirections(combination):
		while m.has(combination.origin.getRelation(d)):
			var nextSquare = combination.origin.getRelation(d)
			SortAlgorithm.Execute(combination.origin.getRelation(d),d)
			var pos = m.find(nextSquare)
			m.pop_at(pos)
			_linealCreation(nextSquare,d)
	combination.origin.setColor(combination.origin.getColor())
	
func _linealCreation(position: SquareComponent, direction):
	position.reset(randi() % 4)
	if position.getHasPotential():
		var combinations = SearchAlgorithm.Execute(position)
		var adyacency = position.getRelation(DirectionsService.GetOppositeDirection(direction))
		for c in combinations:
			if c.members.has(adyacency):
				_linealCreation(position,direction)
