class_name GameBoard extends Node

export(int) var SizeHorizontal
export(int) var SizeVertical

const size: int = 52
const initialSpace: int = 100

var board: Board
var selectedPosition
var allpositions = []

var currentCombinations = []

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
		if allpositions[i].isAnimationOnProgress():
			isanimating = true
		i +=1
	if !isanimating:
		currentCombinations = CleanNonConflictiveCombinationAlgorithm.Execute(board)
		if(currentCombinations.size() > 0):
			if(!DestructionAnimation.Execute(self)):
				DestructionAnimation.Restore(self)
				board.solveCombination(currentCombinations)
				GameBoardAnimation.Execute(self)

func positionClick(position):
	if(position.square.getHasOriginPotential()):
		board.setOriginIfPossible(position.square)
		currentCombinations = CleanNonConflictiveCombinationAlgorithm.Execute(board)
	elif selectedPosition != null:
		selectedPosition.Unselect()
		board.changeColor(selectedPosition.square, position.square)
		selectedPosition = null
	else:
		currentCombinations = CleanNonConflictiveCombinationAlgorithm.Execute(board)
		selectedPosition = position
		selectedPosition.Select()
	GameBoardAnimation.Execute(self)
