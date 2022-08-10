extends State

class_name BuildState


onready var timer = $Timer

var recipe
var position
var instance


func enter(msg := {}):
	if not msg.has('recipe'):
		print('Error: missing recipe on Build state')
		return
	if not msg.has('position'):
		print('Error: missing position on Build state')
		return
	
	recipe = msg.recipe
	position = msg.position
	instance = recipe.instance()
	timer.wait_time = instance.build_time
	timer.start()



func update(delta: float) -> void:
	if timer.paused:
		return
	
	instance.position = position
	instance.z_index = 1
	actor.owner.add_child(instance)
	state_machine.transition('idle')
