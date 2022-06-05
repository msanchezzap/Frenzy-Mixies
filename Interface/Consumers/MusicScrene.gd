extends Node2D

func _ready():
	$AudioStreamPlayer.play()
	pass
func lowSound():
	$AudioStreamPlayer.set_volume_db(-20)
func playButton():
	$AudioStreamPlayer2.play()
func playWand():
	$AudioStreamPlayer3.play()
