class_name SquareCombinationComponent extends SquareCombination

func _init(source: Square, memberlist, oposite: Square).(source, memberlist, oposite):
	pass

func Destroy():
	Locker.new().modify(opposite)
	CombinationDestruction.BasicDestruction(self)
