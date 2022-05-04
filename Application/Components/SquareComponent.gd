class_name SquareComponent extends Square

var _haspotential: bool
var _hasOriginPotential: bool
var _searchAlgorithm = BasicSearchAlgorithm
var _triggerFunction = null
var _type = null

const TYPE_JOKER = "joker"
const TYPE_EXPLOSIVE = "explosive"
const TYPES = [TYPE_JOKER, TYPE_EXPLOSIVE]

func _init(initColor).(initColor):
	pass

func reset(initColor):
	_searchAlgorithm = BasicSearchAlgorithm
	_triggerFunction = null
	_points = 10
	_type = null
	setColor(initColor)

func setColor(newColor: int):
	_color = newColor
	_seePotential(true)

func setHasOriginPotential(potential: bool):
	_hasOriginPotential = potential

func getHasOriginPotential():
	return _hasOriginPotential

func setHasPotential(potential: bool):
	_haspotential = potential

func getHasPotential():
	return _haspotential

func _seePotential(original:bool = false):
	var group = _searchAlgorithm.Execute(self)
	if group.size() > 0:
		if original:
			_hasOriginPotential = true
		_haspotential = true
	else:
		_haspotential = false
		_hasOriginPotential = false
	return _haspotential

func getCombinations():
	return _searchAlgorithm.Execute(self)

func trigger(squareDestiny: Combination):
	if _triggerFunction != null:
		_triggerFunction.trigger(squareDestiny)
		return true
	return false
	
func getType():
	return _type
func setType(type: String):
	if TYPES.has(type):
		_type = type
