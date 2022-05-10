class_name Explosive 

func modify(square):
	square._points = 25
	square._searchAlgorithm = BasicSearchAlgorithm
	square._triggerFunction = ExplosiveTrigger.new(square)
	square.setType(SquareComponent.TYPE_EXPLOSIVE)
