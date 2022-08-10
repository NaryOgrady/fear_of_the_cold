extends GoapAction

class_name EatMushroomAction


func get_class():
	return 'EatMushroomAction'

func get_cost(_blackboard) -> int:
	return 1


func get_effects() -> Dictionary:
	return {
		'is_hungry': false
	}


func perform(actor, _delta) -> bool:
	in_progress = true
	var closest_food = WorldState.get_closest_element('food', actor)
	actor.state_machine.transition('move', { 'destination': closest_food.position})
	yield(actor.state_machine, 'transitioned')

	WorldState.set_state('is_hungry', false)
	closest_food.queue_free()
	emit_signal('finished')

	in_progress = false
	return true
