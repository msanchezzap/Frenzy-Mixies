class_name GameBoard extends Node

export(int) var SizeHorizontal
export(int) var SizeVertical

const size: int = 52
const initialSpace: int = 100

var board
var selectedPosition
var allpositions = []
var _boardAnimation
var menu = null
var score
var gameDisabled = false

func _ready():
	start()

func start():
	board = Board.new(SizeHorizontal,SizeVertical, 3)
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
	_boardAnimation = GameBoardAnimation.new(self)
	
	var newScore = load("res://Interface/Scenes/ScoreBoard.tscn")
	score = newScore.instance()
	add_child(score)
	score.changeTurn(board.getTurnsLeft())
	
func _input(event):
	if event is InputEventKey:
		if event.pressed && event.scancode == KEY_ESCAPE:
			if !is_instance_valid(menu):
				menu = MenuFactory.new().generatePauseMenu()
				add_child(menu)
				gameDisabled = true
			else:
				menu.queue_free()
				gameDisabled = false
		
func isAnimationInProcess():
	var isanimating = false
	var i = 0
	while i < allpositions.size() && !isanimating:
		if allpositions[i].isAnimationOnProgress():
			isanimating = true
		i +=1
	return isanimating
	
func _physics_process(delta):
	if !isAnimationInProcess() && board.hasNextStep() && !DestructionAnimation.Execute(board.getNextStep(), allpositions):
		DestructionAnimation.Restore(board.getNextStep(), allpositions)
		var lastStep = board.getNextStep()
		board.executeNextStep()
		_boardAnimation.Execute(lastStep)
		score.changeScore(board.getScore())
	elif !gameDisabled && board.getTurnsLeft() == 0 && !board.hasNextStep() && !isAnimationInProcess():
		gameDisabled = true
		add_child(MenuFactory.new().generateScoreMenu(board.getScore()))

func positionClick(position):
	if !isAnimationInProcess() && !gameDisabled:
		if(position.square.getHasOriginPotential()):
			board.setOriginIfPossible(position.square)
		elif selectedPosition != null:
			selectedPosition.Unselect()
			board.setNextStep(selectedPosition.square, position.square)
			selectedPosition = null
			if board.hasNextStep():
				score.changeTurn(board.getTurnsLeft())
		else:
			selectedPosition = position
			selectedPosition.Select()
