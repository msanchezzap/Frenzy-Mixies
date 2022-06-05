class_name BoardFactory extends Node

var _x: int
var _y: int
var _level: int
func _init(width:int, height:int, level: int):
	_x = height
	_y = width
	_level = level

func construct():
	var colors = Config.getColorQuantity()
	var firstSquare = null
	var lastRow: SquareComponent = null
	var lastSquare: SquareComponent = null
	var oldX = _x
	var oldY = _y
	if _level == 0:
		_x = 5
		_y = 5
	for n in _x:
		if lastSquare != null:
			lastRow = _getLeftSquare(lastSquare)
			lastSquare = null
		for m in _y:
			var square = SquareComponent.new(randi() % colors)
			if firstSquare == null:
				firstSquare = square
			if(lastSquare != null):
				square.AddRelation(lastSquare,Directions.LEFT)
			if(lastRow != null):
				square.AddRelation(lastRow,Directions.UP)
				lastRow = lastRow.getRelation(Directions.RIGHT)
			while(BasicSearchAlgorithm.Execute(square).size() > 0):
				square.setColor(randi() % colors)
			lastSquare = square
	match _level:
		3:
			var downRight = lastSquare.getRelation(Directions.UP).getRelation(Directions.LEFT)
			var downLeft = lastSquare
			while (downLeft.getRelation(Directions.LEFT) != null):
				downLeft = downLeft.getRelation(Directions.LEFT)
			downLeft = downLeft.getRelation(Directions.UP).getRelation(Directions.RIGHT)
			var UpRight = lastSquare
			while (UpRight.getRelation(Directions.UP) != null):
				UpRight = UpRight.getRelation(Directions.UP)
			UpRight = UpRight.getRelation(Directions.LEFT).getRelation(Directions.DOWN)
			var UpLeft = SquareService.goToStart(UpRight).getRelation(Directions.DOWN).getRelation(Directions.RIGHT)
			var lockfactory = Locker.new()
			lockfactory.modify(UpLeft)
			lockfactory.modify(UpRight)
			lockfactory.modify(downLeft)
			lockfactory.modify(downRight)
		4,7:
			var downRight = lastSquare.getRelation(Directions.UP).getRelation(Directions.LEFT)
			var downLeft = lastSquare
			while (downLeft.getRelation(Directions.LEFT) != null):
				downLeft = downLeft.getRelation(Directions.LEFT)
			downLeft = downLeft.getRelation(Directions.UP).getRelation(Directions.RIGHT)
			var UpRight = lastSquare
			while (UpRight.getRelation(Directions.UP) != null):
				UpRight = UpRight.getRelation(Directions.UP)
			UpRight = UpRight.getRelation(Directions.LEFT).getRelation(Directions.DOWN)
			var UpLeft = SquareService.goToStart(UpRight).getRelation(Directions.DOWN).getRelation(Directions.RIGHT)
			var explosiveFactory = Explosive.new()
			explosiveFactory.modify(UpLeft)
			explosiveFactory.modify(downRight)
		6,9:
			var downRight = lastSquare.getRelation(Directions.UP).getRelation(Directions.LEFT).getRelation(Directions.UP).getRelation(Directions.LEFT)
			var downLeft = lastSquare
			while (downLeft.getRelation(Directions.LEFT) != null):
				downLeft = downLeft.getRelation(Directions.LEFT)
			downLeft = downLeft.getRelation(Directions.UP).getRelation(Directions.RIGHT).getRelation(Directions.UP).getRelation(Directions.RIGHT)
			var UpRight = lastSquare
			while (UpRight.getRelation(Directions.UP) != null):
				UpRight = UpRight.getRelation(Directions.UP)
			UpRight = UpRight.getRelation(Directions.LEFT).getRelation(Directions.DOWN).getRelation(Directions.LEFT).getRelation(Directions.DOWN)
			var UpLeft = SquareService.goToStart(UpRight).getRelation(Directions.DOWN).getRelation(Directions.RIGHT).getRelation(Directions.DOWN).getRelation(Directions.RIGHT)
			var lockfactory = Locker.new()
			lockfactory.modify(UpLeft)
			lockfactory.modify(UpRight)
			lockfactory.modify(downLeft)
			lockfactory.modify(downRight)
	if _level == 0:
		_x = oldX
		_y = oldY
	return firstSquare

func _getLeftSquare(lastSquare: SquareComponent):
	while(lastSquare.getRelation(Directions.LEFT) != null):
		lastSquare = lastSquare.getRelation(Directions.LEFT)
	return lastSquare
