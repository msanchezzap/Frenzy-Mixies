class_name GameBoard extends Node

export(int) var SizeHorizontal
export(int) var SizeVertical

const size: int = 52
const initialSpace: int = 100

var board: Board
var selectedPosition
var allpositions = []

func _ready():
	board = Board.new(SizeHorizontal,SizeVertical)
	var squares = board.getStartSquare()
	var i = 0
	var j = 0
	while squares != null:
		var squaresLine = squares
		while squaresLine != null:
			var pos = load("res://Interface/Scenes/Position.tscn")
			var newPosition = pos.instance().init(self, squaresLine, Vector2(initialSpace + j * size, initialSpace + i * size))
			add_child(newPosition)
			allpositions.append(newPosition)
			squaresLine = squaresLine.getRelation(Directions.RIGHT)
			j += 1
		j = 0
		squares = squares.getRelation(Directions.DOWN)
		i += 1

func _physics_process(delta):
	var isanimating = false
	var i = 0
	while i < allpositions.size() && !isanimating:
		if allpositions[i].isMoving():
			isanimating = true
		i +=1
	if !isanimating:
		currentCombinations = board.cleanNonConflictiveCombinations()
		if(currentCombinations.size() > 0):
			refresh()

var currentCombinations = []
func refresh():
	var positionChange= []
	var i = 0
	var squares = board.getStartSquare()
	while squares != null:
		var squaresLine = squares
		while squaresLine != null:
			var oldPosition = _search(squaresLine)
			positionChange.append(SquareAux.new(allpositions[i].square,allpositions[i].position))
			allpositions[i].square = squaresLine
			var iscombination = false
			for c in currentCombinations:
				if c.members.has(squaresLine):
					allpositions[i].position += setBoardEntrance(allpositions[i], _search(c.origin).position)
					iscombination = true
			if !iscombination:
				if oldPosition != null:
					allpositions[i].position = oldPosition.position
				else:
					var finded = false
					var j = 0
					while !finded && j < positionChange.size():
						if positionChange[j].square == allpositions[i].square:
							finded = true
							allpositions[i].position = positionChange[j].position
						j +=1
			squaresLine = squaresLine.getRelation(Directions.RIGHT)
			i += 1
		squares = squares.getRelation(Directions.DOWN)
	currentCombinations = []

func setBoardEntrance(position, pivot: Vector2):
	var direction = (position.position - pivot).normalized()
	var newPosition = Vector2(0,0)
	if(direction.x > 0):
		newPosition.x += direction.x * size * 2
	elif(direction.y > 0):
		newPosition.y += direction.y * size * 2
	else:
		newPosition = direction * initialSpace
	return newPosition
	
func _search(squareToSearch: SquareComponent):
	for pos in allpositions:
		if pos.square == squareToSearch:
			return pos

func positionClick(position):
	if(position.square.getHasOriginPotential()):
		currentCombinations = board.activeCombination(position.square)
	elif selectedPosition != null:
		selectedPosition.Unselect()
		board.changeColor(selectedPosition.square, position.square)
		selectedPosition = null
	else:
		currentCombinations = board.cleanNonConflictiveCombinations()
		selectedPosition = position
		selectedPosition.Select()
	refresh()
