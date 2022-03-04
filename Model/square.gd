class_name Square extends Node

var _color = 0
var adyacencies: Array = [null,null,null,null]
var haspotential: bool
var hasOriginPotential: bool

func _init(initColor):
	setColor(initColor)

func reset(initColor):
	setColor(initColor)
	
func setColor(newColor):
	_color = newColor
	_seePotential(true)
	
func getColor():
	return _color
	
func AddRelation(square,direction):
	adyacencies[direction] = square
	square.adyacencies[Directions.GetOppositeDirection(direction)] = self

func _exchangeRelation(square,direction):
	var adjs = square.adyacencies[direction]
	if adjs != null:
		adjs.adyacencies[Directions.GetOppositeDirection(direction)] = self
	var adjself = adyacencies[direction]
	if adjself != null:
		adjself.adyacencies[Directions.GetOppositeDirection(direction)] = square
	var tmp = square.adyacencies[direction]
	square.adyacencies[direction] = adyacencies[direction]
	adyacencies[direction] = tmp
	
func ExchangeAll(square):
	for direction in Directions.allDirections:
		_exchangeRelation(square, direction)
	_seePotential(true)
	square._seePotential(true)

func _seePotential(original:bool = false):
	var group = SearchAlgorithm.Execute(self)
	if group.size() > 0:
		if original:
			hasOriginPotential = true
		haspotential = true
	else:
		haspotential = false
		hasOriginPotential = false
	return haspotential
