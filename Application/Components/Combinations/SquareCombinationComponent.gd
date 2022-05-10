class_name SquareCombinationComponent extends SquareCombination

func _init(source: Square, memberlist, oposite: Square).(source, memberlist, oposite):
	pass

func Destroy():
	#Joker.new().modify(opposite)
	var tmp = origin._triggerFunction
	Wand.new().modify(origin)
	origin.trigger(origin)
	origin._triggerFunction = tmp
	CombinationDestruction.BasicDestruction(self)
