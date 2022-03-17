class_name Position extends Area2D

var gameBoard: GameBoard
var square: SquareComponent
var isActive = false
var isHover = false
var basePosition: Vector2
var baseScale: Vector2 = Vector2(0.5,0.5)
var speed = 300
var currentRotation = 0
var currentScale = Vector2(0.5,0.5)

func init(board: GameBoard, square: Square, firstPosition: Vector2):
	basePosition = firstPosition
	position = firstPosition
	self.square = square
	gameBoard = board
	return self

func _physics_process(delta):
	square._seePotential()
	applyColor()
	applyMovement(delta)
	applyScale()
	applyRotation(delta)

func Select():
	isActive = true

func Unselect():
	isActive = false
	
func setColor(color):
	square.activeColor = color
	
func applyColor():
	PositionAnimation.Colorize(self)

func applyScale():
	PositionAnimation.Scale(self, Vector2(0.5,0.5), Vector2(0.02,0.02))

func applyRotation(delta):
	PositionAnimation.Rotate(self, 5)

func setRotation(newRotation):
	currentRotation = newRotation

func setScale(newScale):
	currentScale = newScale
	
func applyMovement(delta):
	PositionAnimation.Move(self,speed, delta)

func isAnimationOnProgress():
	return position != basePosition || scale != currentScale

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.button_index == BUTTON_LEFT && event.is_pressed():
		gameBoard.positionClick(self)

func _on_Area2D_mouse_entered():
	isHover = true

func _on_Area2D_mouse_exited():
	isHover = false
