extends State

class_name Chop


var target

var in_progress = false


func enter(msg := {}) -> void:
	if not msg.has('target'):
		print('Error: missing target on Chop sate')
		return
	
	target = msg.target


func update(_delta: float) -> void:
	if in_progress:
		return
	target.chop()
	in_progress = true

	yield(target, 'chopped')

	state_machine.transition('idle')
	in_progress = false
