class_name BasicLinealCreation extends Node

func execute(position: SquareComponent, direction):
	position.reset(randi() % 4)
	if position.getHasPotential():
		var combinations = BasicSearchAlgorithm.Execute(position)
		var adyacency = position.getRelation(DirectionsService.GetOppositeDirection(direction))
		for c in combinations:
			if c.members.has(adyacency):
				execute(position,direction)
