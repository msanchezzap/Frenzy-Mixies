extends Area2D


var currentScore = 0
var destinyScore = 0
var turnsLeft = 0
func _physics_process(delta):
	if destinyScore != currentScore:
		currentScore += 1
		$Label.text = str(currentScore) 
	
func changeScore(newScore: int):
	destinyScore = newScore
	
func changeTurn(turn: int):
	turnsLeft = str(turn)
	$Label2.text = turnsLeft
