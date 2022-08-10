extends Node


class_name StateMachine

signal transitioned(state_name)


onready var state : State = get_child(0)


func _ready() -> void:
	yield(owner, 'ready')
	state.enter()


func _process(delta: float) -> void:
	state.update(delta)


func _physics_process(delta: float) -> void:
	state.physics_update(delta)


func transition(target_state_name: String, msg: Dictionary = {}, emit=true) -> void:
	if not has_node(target_state_name):
		print('Error: target state does not exist.')
		return
	
	state.exit()
	state = get_node(target_state_name)
	state.enter(msg)
	
	if emit:
		emit_signal('transitioned', state.name)
