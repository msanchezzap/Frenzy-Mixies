class_name SquareCombinationComponent extends SquareCombination

var wandColor: ConditionsService

func _init(source: Square, memberlist, oposite: Square).(source, memberlist, oposite):
	pass

func Destroy():
	_wandProcess()
	CombinationDestruction.BasicDestruction(self)

func setStatService(conditionService):
	wandColor = conditionService
	
func _wandProcess():
	Wand.new().modify(opposite, wandColor)
	opposite.trigger(origin)
	opposite.reset(opposite.getColor())
