class_name BasicLinealCreation extends Node

func execute(position, direction: int , retryPolicy: bool = true):
	position.reset(randi() % 4)
	if position.getHasPotential() && retryPolicy:
		var combinations = BasicSearchAlgorithm.Execute(position)
		var adyacency = position.getRelation(DirectionsService.GetOppositeDirection(direction))
		for c in combinations:
			if c.members.has(adyacency):
				execute(position,direction, false)
				return
