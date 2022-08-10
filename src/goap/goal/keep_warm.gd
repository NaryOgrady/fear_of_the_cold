extends GoapGoal

class_name KeepWarmGoal


var _actor


func get_class():
	return 'KeepWarmGoal'


func _init(actor):
	_actor = actor

func is_valid() -> bool:
	return WorldState.get_elements('firepit').size() == 0


func priority() -> int:
	return 3


func get_desired_state() -> Dictionary:
	return {
		'is_cold': false
	}
