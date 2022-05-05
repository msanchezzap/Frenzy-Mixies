extends Node

func Execute(origin: Square, direction):
	if origin.getRelation(direction) != null:
		var nextPosition = origin.getRelation(direction)
		while nextPosition != null && nextPosition.getType() == SquareComponent.TYPE_LOCKER:
			nextPosition = nextPosition.getRelation(direction)
		if nextPosition != null:
			SquareService.ExchangeAll(origin, nextPosition)
			Execute(origin, direction)
