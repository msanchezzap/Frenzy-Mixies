class_name Cauldron 

func modify(square):
	square._points = 20
	square._triggerFunction = CauldronTrigger.new(square)
