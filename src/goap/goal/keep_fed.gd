extends GoapGoal

class_name KeepFedGoal


var _actor


func get_class():
	return 'KeepFedGoal'


func _init(actor):
	_actor = actor


func is_valid() -> bool:
	return WorldState.get_state('is_hungry')


func priority() -> int:
	return 5


func get_desired_state() -> Dictionary:
	return {
		'is_hungry': false
	}