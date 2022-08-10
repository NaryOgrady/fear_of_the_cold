extends GoapAction

class_name ChopTreeAction


func get_class():
	return 'ChopTreeAction'


func is_valid() -> bool:
	# return WorldState.get_elements('tree').size() > 0
	return true


func get_cost(blackboard) -> int:
	# Todo calculate cost
	# if blackboard.has('position'):
	# 	var closest_tree = WorldState.get_closest_element('tree', blackboard)
	# 	return int(closest_tree.position.distance_to(blackboard.position) / 7)
	return 3


func get_preconditions() -> Dictionary:
	return {}


func get_effects() -> Dictionary:
	return {
		'has_wood': true
	}


func perform(actor, _delta) -> bool:
	in_progress = true
	var closest_tree = WorldState.get_closest_element('tree', actor)
	actor.state_machine.transition('move', { 'destination': closest_tree.position})
	yield(actor.state_machine, 'transitioned')

	actor.state_machine.transition('chop', { 'target': closest_tree }, false)
	yield(actor.state_machine, 'transitioned')

	WorldState.set_state('has_wood', true)

	emit_signal('finished')
	in_progress = false
	# TODO: clean this shit
	return true

