class_name Position extends Area2D

var gameBoard: GameBoard
var square: SquareComponent
var isActive = false
var isHover = false
var basePosition: Vector2
var speed = 300

func init(board: GameBoard, square: Square, firstPosition: Vector2):
	basePosition = firstPosition
	position = firstPosition
	_setSquare(square)
	_setGameBoard(board)
	return self

func _physics_process(delta):
	square._seePotential()
	applyColor()
	applyMovement(delta)

func _setSquare(newSquare):
	square = newSquare
	
func _setGameBoard(newGameBoard: GameBoard):
	gameBoard = newGameBoard

func Select():
	isActive = true

func Unselect():
	isActive = false
	
func setColor(color):
	square.activeColor = color
	
func applyColor():
	var colorCalculated = ColorsService.GetColor(square.getColor())
	if(isHover):
		colorCalculated += ColorsService.LIGHT
	if(isActive || square.getHasPotential() ):
		colorCalculated = ColorsService.GetSaturatedColor(square.getColor())
	if(square.getHasOriginPotential()):
		colorCalculated = ColorsService.getOriginColor(square.getColor())
	$AnimatedSprite.modulate = colorCalculated

func applyMovement(delta):
	PositionAnimation.Execute(self,speed, delta)

func isMoving():
	return position != basePosition

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.button_index == BUTTON_LEFT && event.is_pressed():
		gameBoard.positionClick(self)

func _on_Area2D_mouse_entered():
	isHover = true

func _on_Area2D_mouse_exited():
	isHover = false
