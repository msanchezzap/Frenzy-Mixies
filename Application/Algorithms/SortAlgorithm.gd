extends Node

func Execute(origin: Square, direction):
	if origin.getRelation(direction) != null:
		var nextPosition = origin.getRelation(direction)
		origin.ExchangeAll(nextPosition)
		Execute(origin, direction)
