class_name LinealCombinationComponent extends Combination

func _init(source: Square, memberlist).(source, memberlist):
	pass

func Destroy():
	CombinationDestruction.BasicDestruction(self)
	if members.size() == 4:
		pass
	if members.size() == 3:
		Explosive.new().modify(origin)
