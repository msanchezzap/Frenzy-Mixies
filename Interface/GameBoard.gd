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

var currentCombinations = []
func refresh():
	var positionChange= []
	var i = 0
	var squares = board.getStartSquare()
	while squares != null:
		var squaresLine = squares
		while squaresLine != null:
			var oldPosition = _search(squaresLine)
			allpositions[i].square = squaresLine
			var iscombination = false
			for c in currentCombinations:
				if c.members.has(squaresLine):
					allpositions[i].position += setBoardEntrance(allpositions[i], _search(c.origin).position)
					iscombination = true
			if !iscombination:
				allpositions[i].position = oldPosition.position
			squaresLine = squaresLine.getRelation(Directions.RIGHT)
			i += 1
		squares = squares.getRelation(Directions.DOWN)

func setBoardEntrance(position, pivot: Vector2):
	var direction = (position.position - pivot).normalized()
	var newPosition = direction * initialSpace
	if(direction.x > 0):
		newPosition.x += size * SizeHorizontal
	if(direction.y > 0):
		newPosition.y += size * SizeHorizontal
	return newPosition

func _search(squareToSearch: SquareComponent):
	var i = 0
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
