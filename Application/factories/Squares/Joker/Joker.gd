class_name Joker 

var _linealCreation = BasicLinealCreation
var _jokerTrigger = JokerTrigger

func modify(square):
	square._points = 25
	square._searchAlgorithm = JokerSearch
	square.setColor(Colors.JOKER)
	square._triggerFunction = JokerTrigger.new(square)
	square.setType(SquareComponent.TYPE_JOKER)
