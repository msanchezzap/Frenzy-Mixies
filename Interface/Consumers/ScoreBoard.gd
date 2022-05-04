extends Area2D


var currentScore = 0
var destinyScore = 0
var turnsLeft = 0
func _ready():
	$Score.set_position(Vector2(get_viewport().size.x/1.3, get_viewport().size.y/7))
	$ScoreValue.set_position(Vector2(get_viewport().size.x/1.2, get_viewport().size.y/7))
	$TurnsLeft.set_position(Vector2(get_viewport().size.x/1.3, get_viewport().size.y/5.5))
	$TurnsLeftValue.set_position(Vector2(get_viewport().size.x/1.2, get_viewport().size.y/5.5))
	$Objectives.set_position(Vector2(get_viewport().size.x/1.3, get_viewport().size.y/4.5))
	$ObjectivesValue.set_position(Vector2(get_viewport().size.x/1.2, get_viewport().size.y/4.5))
func _physics_process(delta):
	if destinyScore != currentScore:
		currentScore += 1
		$ScoreValue.text = str(currentScore) 
	
func changeScore(newScore: int):
	destinyScore = newScore
	
func changeTurn(turn: int):
	turnsLeft = str(turn)
	$TurnsLeftValue.text = turnsLeft
	
func changeObjectives(objectives: Array):
	var result = ""
	for o in objectives:
		result += "- " + o[0] + ": " + str(o[1]) + "/" + str(o[2]) + "\n"
	$ObjectivesValue.text = result
