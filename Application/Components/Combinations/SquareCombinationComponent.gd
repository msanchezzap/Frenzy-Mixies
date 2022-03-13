class_name SquareCombinationComponent extends SquareCombination

func _init(source: Square, memberlist, oposite: Square).(source, memberlist, oposite):
	pass

func Destroy():
	#opposite.setColor(Colors.JOKER)
	CombinationDestruction.BasicDestruction(self)
