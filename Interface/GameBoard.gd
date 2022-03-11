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

func isAnimationInProcess():
	var isanimating = false
	var i = 0
	while i < allpositions.size() && !isanimating:
		if allpositions[i].isAnimationOnProgress():
			isanimating = true
		i +=1
	return isanimating
	
func _physics_process(delta):
	if !isAnimationInProcess() && currentCombinations.size() > 0:
		if(!DestructionAnimation.Execute(currentCombinations, allpositions)):
			DestructionAnimation.Restore(currentCombinations, allpositions)
			board.solveCombination(currentCombinations)
			GameBoardAnimation.Execute(self)
			currentCombinations = CleanNonConflictiveCombinationAlgorithm.Execute(board)

func positionClick(position):
	if !isAnimationInProcess():
		if(position.square.getHasOriginPotential()):
			board.setOriginIfPossible(position.square)
		elif selectedPosition != null:
			selectedPosition.Unselect()
			board.changeColor(selectedPosition.square, position.square)
			selectedPosition = null
		else:
			selectedPosition = position
			selectedPosition.Select()
		currentCombinations = CleanNonConflictiveCombinationAlgorithm.Execute(board)
