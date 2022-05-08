class_name Locker 

func modify(square):
	square._points = 50
	square._triggerFunction = LockerTrigger.new(square)
	square._resetAlgorithm = LockerResetAlgorithm.new(square)
	square._destructionAlgorithm = LockerDestructionAlgorithm.new(square)
	square.setType(SquareComponent.TYPE_LOCKER)
