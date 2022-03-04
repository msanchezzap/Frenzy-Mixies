extends Node

func _exchangeRelation(squareOrigin:Square, direction, squareToExchange: Square):
	var adjs: Square = squareToExchange.getRelation(direction)
	if adjs != null:
		adjs.SetRelation(squareOrigin, DirectionsService.GetOppositeDirection(direction))
	var adjself: Square = squareOrigin.getRelation(direction)
	if adjself != null:
		adjself.SetRelation(squareToExchange, DirectionsService.GetOppositeDirection(direction))
	var tmp = squareToExchange.getRelation(direction)
	squareToExchange.SetRelation(squareOrigin.getRelation(direction), direction)
	squareOrigin.SetRelation(tmp, direction)

func ExchangeAll(squareOrigin:Square, squareToExchange: Square):
	for direction in DirectionsService.getAllDirections():
		_exchangeRelation(squareOrigin, direction, squareToExchange)
	squareOrigin._seePotential(true)
	squareToExchange._seePotential( true)


func goToStart(square: Square):
	if square.getRelation(Directions.UP) != null:
		return goToStart(square.getRelation(Directions.UP))
	if square.getRelation(Directions.LEFT) != null:
		return goToStart(square.getRelation(Directions.LEFT))
	return square
