extends Node2D

var disableMusic = false
var disableSound = false

func _ready():
	$AudioStreamPlayer.set_volume_db(-15)
	$AudioStreamPlayer2.set_volume_db(-10)
	if !disableMusic:
		$AudioStreamPlayer.play()

func setDisableMusic():
	disableMusic = !disableMusic
	if disableMusic:
		$AudioStreamPlayer.stop()
	else:
		$AudioStreamPlayer.play()
func setDisableSound():
	disableSound = !disableSound
func playButton():
	if !disableSound:
		$AudioStreamPlayer2.play()
func playWand():
	if !disableSound:
		$AudioStreamPlayer3.play()
func playWaterDone():
	if !disableSound:
		$AudioStreamPlayer4.play()
func playWater():
	if !disableSound:
		$AudioStreamPlayer5.play()
func playForest():
	if !disableSound:
		$AudioStreamPlayer6.play()
func stopForest():
	if !disableSound:
		$AudioStreamPlayer6.stop()
func playOrganic():
	if !disableSound:
		$AudioStreamPlayer7.play()
func playCombination():
	if !disableSound:
		$AudioStreamPlayer8.play()
