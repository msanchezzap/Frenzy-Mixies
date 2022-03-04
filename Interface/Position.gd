class_name Position extends Area2D

var movement: Vector2 = Vector2(0, 0)
var gameBoard: GameBoard
var square: Square
var isActive = false
var isHover = false
var adyacencies = [null,null,null,null]

func _physics_process(delta):
	applyColor()

func SetSquare(newSquare):
	square = newSquare
	
func SetGameBoard(newGameBoard: GameBoard):
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
	var colorCalculated = Colors.GetColor(square.getColor())
	if(isHover):
		colorCalculated += Colors.LIGHT
	if(isActive || square._seePotential() ):
		colorCalculated = Colors.GetSaturatedColor(square.getColor())
	if(square.hasOriginPotential):
		colorCalculated = Colors.LIGHT
	$AnimatedSprite.modulate = colorCalculated

func setDirection(newDirection):
	movement = newDirection

func applyMovement(delta):
	if movement != Vector2(0,0):
		var speed = 100
		var velocity = Vector2.ZERO # The player's movement vector.
		velocity.x += 1
		velocity = velocity.normalized() * speed
		move(movement * delta)

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
	if local_shape_index == Directions.GetDirection(movement):
		movement = Vector2(0,0)
	var position = area.get_owner()
	if position != null:
		adyacencies[local_shape_index] = position
