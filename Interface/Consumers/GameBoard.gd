class_name GameBoard extends Node

const size: int = 75
const initialSpaceY: int = 35
var initialSpaceX: int = 0

var board
var selectedPosition
var allpositions = []
var _boardAnimation
var menu = null
var score
var gameDisabled = false

var isTransitioning = false
var lastStep = []
var oldStep = []

func _ready():
	initialSpaceX = get_viewport().size.x/5
	setBackgroundSize()
	start()

func setBackgroundSize():
	var viewportWidth = get_viewport().size.x
	var viewportHeight = get_viewport().size.y
	var scale = viewportWidth / $Background.texture.get_size().x
	$Background.set_position(Vector2(viewportWidth/2, viewportHeight/2))
	$Background.set_scale(Vector2(scale, scale))

func start():
	_initGame()
	_generateBoard()
	_initScore()
	_boardAnimation = GameBoardAnimation.new(self)

func _initGame():
	board = GameService.new(Config.getConfigValue(),Config.getConfigValue(), Config.getTurns())

func _generateBoard():
	var squares = board.getStartSquare()
	var i = 0
	var j = 0
	while squares != null:
		var squaresLine = squares
		while squaresLine != null:
			var pos = load("res://Interface/Scenes/Components/Position.tscn")
			var newPosition = pos.instance().init(self, squaresLine, Vector2(initialSpaceX + j * size, initialSpaceY + i * size))
			add_child(newPosition)
			allpositions.append(newPosition)
			squaresLine = squaresLine.getRelation(Directions.RIGHT)
			j += 1
		j = 0
		squares = squares.getRelation(Directions.DOWN)
		i += 1

func _initScore():
	var newScore = load("res://Interface/Scenes/Components/ScoreBoard.tscn")
	score = newScore.instance()
	add_child(score)
	score.changeTurn(board.getTurnsLeft())
	score.changeObjectives(board.getConditions())
	
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
	elif event is InputEventMouseButton:
		if selectedPosition != null:
			var isHover = false
			for pos in allpositions:
				if pos.isHover:
					isHover = true
			if !isHover:
					selectedPosition.Unselect()
					selectedPosition = null

func isAnimationInProcess():
	var isanimating = false
	var i = 0
	while i < allpositions.size() && !isanimating:
		if allpositions[i].isAnimationOnProgress():
			isanimating = true
		i +=1
	return isanimating

func _physics_process(delta):
	if isAnimationInProcess():
		for p  in allpositions:
			p.isBoardAnimationInProgress = true
		isTransitioning = true
	if !isAnimationInProcess() && board.hasNextStep():
		var next = board.getNextStep()
		var tmp = []
		if next.size() > 0:
			tmp = DestructionAnimation.Execute([board.getNextStep()[0]], allpositions)
		if tmp.size() == 0:
			DestructionAnimation.RestorePositions(oldStep)
			oldStep = []
			lastStep = board.executeNextStep()
			if lastStep.size() > 0:
				_boardAnimation.Execute(lastStep[0], board.getChain())
				score.changeScore(board.getScore())
				score.changeObjectives(board.getConditions())
		else:
			oldStep += tmp
	elif !gameDisabled && !board.hasNextStep() && !isAnimationInProcess():
		if !board.isPendingConflicts() && isTransitioning:
			for p  in allpositions:
				p.isBoardAnimationInProgress = false
				p.isConflictPending = false
			isTransitioning = false
		if board.isPendingConflicts() && isTransitioning:
			for p  in allpositions:
				p.isConflictPending = true
		if board.getWinState():
			Config._stars[Config.getLevel()-1] = 3
			if Config.getLevel() == Config.getMaxLevel():
				Config.setMaxLevel(Config.getMaxLevel() + 1)
				Config.advanceLevel()
			gameDisabled = true
			add_child(MenuFactory.new().generateWinMenu(board.getScore()))
		elif board.getTurnsLeft() == 0:
			gameDisabled = true
			add_child(MenuFactory.new().generateGameOverMenu(board.getScore()))

func positionClick(position):
	if !isAnimationInProcess() && !gameDisabled:
		if(board.isPendingConflicts() && position.square.getHasOriginPotential()):
			board.setOriginIfPossible(position.square)
		elif !board.isPendingConflicts():
			if selectedPosition != null:
				selectedPosition.Unselect()
				board.setNextStep(selectedPosition.square, position.square)
				selectedPosition = null
				if board.hasNextStep():
					score.changeTurn(board.getTurnsLeft())
			else:
				selectedPosition = position
				selectedPosition.Select()
