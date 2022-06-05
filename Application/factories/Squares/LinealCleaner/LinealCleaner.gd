class_name LinealCleaner 

func modify(square, horizontal):
	square._triggerFunction = LinealCleanerTrigger.new(square, horizontal)
	if horizontal == true:
		square._points = 75
		square.setType(SquareComponent.LINE_HORIZONTAL)
	elif horizontal == false:
		square._points = 75
		square.setType(SquareComponent.LINE_VERTICAL)
	else:
		square._points = 150
		square.setType(SquareComponent.LINE_DOUBLE)
