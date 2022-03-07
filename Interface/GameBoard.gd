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

func refresh():
	var i = 0
	var squares = board.getStartSquare()
	while squares != null:
		var squaresLine = squares
		while squaresLine != null:
			if allpositions[i].square != squaresLine:
				var oldPosition = _search(squaresLine, i)
				if(oldPosition.hasPotentialLastproccess):
					allpositions[i].hasPotentialLastproccess = true
					oldPosition.hasPotentialLastproccess = false
				allpositions[i].moveFrom(oldPosition.position)
			squaresLine = squaresLine.getRelation(Directions.RIGHT)
			i += 1
		squares = squares.getRelation(Directions.DOWN)
	squares = board.getStartSquare()
	i = 0
	
	while squares != null:
		var squaresLine = squares
		while squaresLine != null:
			allpositions[i].square = squaresLine
			squaresLine = squaresLine.getRelation(Directions.RIGHT)
			i += 1
		squares = squares.getRelation(Directions.DOWN)

func _search(squareToSearch: SquareComponent, newPosition):
	var i = 0
	for pos in allpositions:
		if pos.square == squareToSearch:
			return pos

func positionClick(position):
	if(position.square.getHasOriginPotential()):
		board.activeCombination(position.square)
	elif selectedPosition != null:
		selectedPosition.Unselect()
		board.changeColor(selectedPosition.square, position.square)
		selectedPosition = null
	else:
		board.cleanNonConflictiveCombinations()
		selectedPosition = position
		selectedPosition.Select()
	refresh()
