class_name GameBoard extends Node

const size: int = 80
var initialSpaceY: int = 120
var initialSpaceX: int = 0
var _saveService: SaveService
var board: GameService
var selectedPosition
var allpositions = []
var _boardAnimation
var menu = null
var score
var gameDisabled = false
var listenerInterfaces = []

var isTransitioning = false
var lastStep = []
var oldStep = []

func _init():
	_saveService = SaveService.new()
	if Config.getLevel() == 0:
			var tutorialInterface = load("res://Interface/Scenes/Components/Tutorial.tscn").instance()
			listenerInterfaces.append(tutorialInterface)
			add_child(tutorialInterface)
		
func _ready():
	initialSpaceX = get_viewport().size.x/2.5
	initialSpaceY = get_viewport().size.y/5
	setBackgroundSize()
	start()
	get_tree().get_root().connect("size_changed", self, "resize")
	

func setElementPositionAndSize():
	setBackgroundSize()
	setboardPosition()
	
func setboardPosition():
	for node in self.get_children():
		if "basePosition" in node:
			var viewportWidth = OS.get_window_size().x
			var viewportHeight = OS.get_window_size().y
			var newPosition = Vector2(viewportWidth/2.5 + (allpositions.find(node)%8) * size, initialSpaceY + (allpositions.find(node)/8) * size)
			node.basePosition = newPosition
			node.position = newPosition

func resize():
	setElementPositionAndSize()

func setBackgroundSize():
	var viewportWidth = OS.get_window_size().x
	var viewportHeight = OS.get_window_size().y
	var scale = viewportWidth / $Background.texture.get_size().x
	var scaley = viewportHeight / $Background.texture.get_size().y
	$Background.set_position(Vector2(viewportWidth/2, viewportHeight/2))
	$Background.set_scale(Vector2(scale, scaley))

func start():
	_initGame()
	_generateBoard()
	_initScore()
	_boardAnimation = GameBoardAnimation.new(self)

func _initGame():
	board = GameService.new(Config.getConfigValue(),Config.getConfigValue())

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

var currentSpecial = null
var lastSpecial = null
func _physics_process(delta):
	$FPS.text = "FPS: " + str(Engine.get_frames_per_second()) 
	$RAM.text = "RAM: " + str(stepify(OS.get_static_memory_usage() / 1000000.0,0.01)) +"MB"
	if isAnimationInProcess():
		for p  in allpositions:
			p.isBoardAnimationInProgress = true
		isTransitioning = true
	if !isAnimationInProcess() && falseMovementInProcess != null && !falseMovementInProcess.isProcessing():
		falseMovementInProcess.Execute()
		falseMovementInProcess = null
	if !isAnimationInProcess() && board.hasNextStep():
		var next = board.getNextStep()
		var tmp = []
		if next.size() > 0 && next[0][0] is SquareCombinationComponent:
			_executeSpecialAnimation(next)
		if currentSpecial == null:
			if next.size() > 0:
				tmp = DestructionAnimation.Execute([next[0]], allpositions)
			if tmp.size() == 0:
				DestructionAnimation.RestorePositions(oldStep)
				oldStep = []
				lastStep = board.executeNextStep()
				if lastStep.size() > 0:
					_boardAnimation.Execute(lastStep[0], board.getChain())
					score.changeScore(board.getScore())
					score.changeObjectives(board.getConditions())
					score.changeStars(board.getStars())
			else:
				MusicScrene.playCombination()
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
		match board.getGameStatus():
			board.WIN:
				_winGame()
			board.LOSE:
				_loseGame()

func _executeSpecialAnimation(next):
	if currentSpecial == null && next[0][0] != lastSpecial:
		currentSpecial = preload("res://Interface/Scenes/Components/Special.tscn").instance()
		currentSpecial.setAnimation(next[0][0])
		add_child(currentSpecial)
	if  currentSpecial != null && currentSpecial.isAnimationInProgress == false:
		lastSpecial = next[0][0] 
		currentSpecial.queue_free()
		currentSpecial = null

func _winGame():
	Config._stars[Config.getLevel()-1] = board.getStars()
	if Config.getLevel() == Config.getMaxLevel():
		Config.setMaxLevel(Config.getMaxLevel() + 1)
		Config.advanceLevel()
	gameDisabled = true
	add_child(MenuFactory.new().generateWinMenu(board.getScore(), board.getStars()))
	_saveService.save()
func _loseGame():
	gameDisabled = true
	add_child(MenuFactory.new().generateGameOverMenu(board.getScore()))

var falseMovementInProcess
func positionClick(position):
	if !isAnimationInProcess() && !gameDisabled:
		if(board.isPendingConflicts() && position.square.getHasOriginPotential()):
			board.setOriginIfPossible(position.square)
		else:
			if selectedPosition != null:
				selectedPosition.Unselect()
				board.setNextStep(selectedPosition.square, position.square)
				if !board.hasNextStep():
					falseMovementInProcess = FalseMovementAnimation.new(position,selectedPosition)
					falseMovementInProcess.Execute()
				if board.hasNextStep():
					_boardAnimation.Execute([], board.getChain())
					score.changeTurn(board.getTurnsLeft())
					for l in listenerInterfaces:
						l.notify()
				selectedPosition = null
			else:
				selectedPosition = position
				selectedPosition.Select()
