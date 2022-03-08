class_name Position extends Area2D

var movement: Vector2 = Vector2(0, 0)
var gameBoard: GameBoard
var square: SquareComponent
var isActive = false
var isHover = false
var adyacencies = [null,null,null,null]
var basePosition: Vector2
var nextPosition: Vector2 = Vector2(0,0)

func init(board: GameBoard, square: Square, firstPosition: Vector2):
	basePosition = firstPosition
	position = firstPosition
	_setSquare(square)
	_setGameBoard(board)
	return self

func _physics_process(delta):
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

func Exchange(newSquare: Position):
	var tmps = self.square
	self.square = newSquare.square
	newSquare.square = tmps
	return SearchAlgorithm.Execute(square)
	
func setColor(color):
	square.activeColor = color
	
func applyColor():
	var colorCalculated = ColorsService.GetColor(square.getColor())
	if(isHover):
		colorCalculated += ColorsService.LIGHT
	if(isActive || square._seePotential() ):
		colorCalculated = ColorsService.GetSaturatedColor(square.getColor())
	if(square.getHasOriginPotential()):
		colorCalculated = ColorsService.getOriginColor(square.getColor())
	$AnimatedSprite.modulate = colorCalculated

func setDirection(newDirection):
	movement = newDirection

func applyMovement(delta):
	if position != basePosition:
		if (basePosition - position).x < 1 && (basePosition - position).x > -1 && (basePosition - position).y < 1 && (basePosition - position).y > -1 :
			position = basePosition
		else:
			var direction = (basePosition - position).normalized()
			position += (direction * 100 * delta)

func moveFrom(coords: Vector2):
	nextPosition = coords
	
func move(directionWithSpeed):
	$AnimatedSprite.play()
	position += directionWithSpeed

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.button_index == BUTTON_LEFT && event.is_pressed():
		if self.has_method("applyMovement"):
			gameBoard.positionClick(self)

func _on_Area2D_mouse_entered():
	isHover = true

func _on_Area2D_mouse_exited():
	isHover = false

func _on_Area2D_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	adyacencies[local_shape_index] = null

func _on_Area2D_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if local_shape_index == DirectionsService.GetDirection(movement):
		movement = Vector2(0,0)
	var position = area.get_owner()
	if position != null:
		adyacencies[local_shape_index] = position
