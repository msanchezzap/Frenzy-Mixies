class_name GameBoard extends Node

export(int) var SizeHorizontal
export(int) var SizeVertical

var board: Board
var selectedPosition
var allpositions =[]

func _init():
	board = Board.new(8,8)
	var squares = board.getStartSquare()
	var i = 0
	var j = 0
	while squares != null:
		var squaresLine = squares
		while squaresLine != null:
			var pos = load("res://Interface/Scenes/Position.tscn")
			var newPosition = pos.instance()
			newPosition.SetSquare(squaresLine)
			newPosition.SetGameBoard(self)
			newPosition.position = Vector2(100+j*52, 100+i*52)
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
			allpositions[i].square = squaresLine
			squaresLine = squaresLine.getRelation(Directions.RIGHT)
			i += 1
		squares = squares.getRelation(Directions.DOWN)

func positionClick(position):
	if(position.square.getHasOriginPotential()):
		board.activeCombination(position.square)
	elif selectedPosition != null:
		selectedPosition.Unselect()
		board.changeColor(position.square, selectedPosition.square.getColor())
		selectedPosition = null
	else:
		selectedPosition = position
		selectedPosition.Select()
	refresh()
