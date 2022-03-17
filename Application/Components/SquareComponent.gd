class_name SquareComponent extends Square

var _haspotential: bool
var _hasOriginPotential: bool
var _searchAlgorithm = SearchAlgorithm
var _triggerFunction = null

func _init(initColor).(initColor):
	pass

func reset(initColor):
	_searchAlgorithm = SearchAlgorithm
	_triggerFunction = null
	_points = 10
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

func trigger(squareDestiny: SquareComponent):
	if _triggerFunction != null:
		_triggerFunction.trigger(squareDestiny)
