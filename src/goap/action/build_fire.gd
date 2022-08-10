extends GoapAction


class_name BuildFireAction


const Firepit = preload('res://scenes/Firepit.tscn')

func get_class():
	return 'ChopTreeAction'


func get_cost(_blackboard) -> int:
	return 1


func get_preconditions() -> Dictionary:
	return {
		'has_wood': true
	}


func get_effects() -> Dictionary:
	return {
		'is_cold': false
	}


func perform(actor, _delta) -> bool:
	in_progress = true
	var fire_spot = WorldState.get_closest_element('fire_spot', actor)
	actor.state_machine.transition('move', { 'destination': fire_spot.position}, false)
	yield(actor.state_machine, 'transitioned')


	actor.state_machine.transition(
		'build', { 'recipe': Firepit, 'position': fire_spot.position }, false
	)
	yield(actor.state_machine, 'transitioned')

	WorldState.set_state('is_cold', false)
	WorldState.set_state('has_wood', false)
	emit_signal('finished')

	in_progress = false
	return true
