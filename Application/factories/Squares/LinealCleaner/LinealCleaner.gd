class_name LinealCleaner 

func modify(square, horizontal):
	square._points = 25
	square._triggerFunction = LinealCleanerTrigger.new(square, horizontal)
	if horizontal == true:
		square.setType(SquareComponent.LINE_HORIZONTAL)
	elif horizontal == false:
		square.setType(SquareComponent.LINE_VERTICAL)
	else:
		square.setType(SquareComponent.LINE_DOUBLE)
