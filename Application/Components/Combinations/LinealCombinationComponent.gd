class_name LinealCombinationComponent extends Combination

func _init(source: Square, memberlist).(source, memberlist):
	pass

func Destroy():
	if members.size() == 4:
		Cauldron.new().modify(origin)
		origin.trigger(origin)
	CombinationDestruction.BasicDestruction(self)
	if members.size() == 3:
		Explosive.new().modify(origin)
