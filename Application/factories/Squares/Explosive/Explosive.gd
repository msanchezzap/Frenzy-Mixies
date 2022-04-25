class_name Explosive 

var _linealCreation = BasicLinealCreation
var _trigger = ExplosiveTrigger

func modify(square):
	square._points = 25
	square._searchAlgorithm = BasicSearchAlgorithm
	square._triggerFunction = ExplosiveTrigger.new(square)
	square._type = "explosive"
