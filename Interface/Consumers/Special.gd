extends Node2D

var combination
var isAnimationInProgress = true
var time = 0
func setAnimation(squareCombination):
	combination = squareCombination

func _physics_process(delta):
	$AnimatedSprite.position.x += 1
	time += 1
	if time == 10:
		isAnimationInProgress = false
