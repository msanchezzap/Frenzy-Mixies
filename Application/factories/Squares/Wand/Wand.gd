class_name Wand 

func modify(square, conditionService):
	square._points = 50
	square._triggerFunction = WandTrigger.new(square, conditionService)
	
