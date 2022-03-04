class_name Square extends Node

var _color = 0
var _adyacencies: Array = [null,null,null,null]
var _haspotential: bool
var _hasOriginPotential: bool

func _init(initColor):
	setColor(initColor)

func reset(initColor):
	setColor(initColor)
	
func setColor(newColor):
	_color = newColor
	_seePotential(true)
	
func getColor():
	return _color

func SetRelation(square: Square, direction):
	_adyacencies[direction] = square
	
func getRelation(direction: int):
	return _adyacencies[direction]

func hasOriginPotential():
	return _hasOriginPotential

func AddRelation(square: Square,direction):
	SetRelation(square, direction)
	square.SetRelation(self,DirectionsService.GetOppositeDirection(direction))

func _exchangeRelation(square: Square, direction):
	var adjs: Square = square.getRelation(direction)
	if adjs != null:
		adjs.SetRelation(self, DirectionsService.GetOppositeDirection(direction))
	var adjself: Square = self.getRelation(direction)
	if adjself != null:
		adjself.SetRelation(square, DirectionsService.GetOppositeDirection(direction))
	var tmp = square.getRelation(direction)
	square.SetRelation(self.getRelation(direction), direction)
	self.SetRelation(tmp, direction)

func _seePotential(original:bool = false):
	var group = SearchAlgorithm.Execute(self)
	if group.size() > 0:
		if original:
			_hasOriginPotential = true
		_haspotential = true
	else:
		_haspotential = false
		_hasOriginPotential = false
	return _haspotential
	
func ExchangeAll(square: Square):
	for direction in DirectionsService.getAllDirections():
		_exchangeRelation(square, direction)
	_seePotential(true)
	square._seePotential(true)


