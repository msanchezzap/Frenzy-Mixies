class_name Square extends Node

var color = 0
var adyacencies: Array = [null,null,null,null]
var haspotential: bool
var hasOriginPotential: bool
func init(initColor):
	color = initColor
	
func _init(initColor):
	color = initColor
	
func changeColor(newColor):
	color = newColor

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
		elif !hasOriginPotential:
			haspotential = true
	else:
		haspotential = false
		hasOriginPotential = false
	return haspotential
