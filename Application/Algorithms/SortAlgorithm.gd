extends Node

func Execute(origin: Square, direction):
	if origin.adyacencies[direction] != null:
		var nextPosition = origin.adyacencies[direction]
		origin.ExchangeAll(nextPosition)
		Execute(origin, direction)
