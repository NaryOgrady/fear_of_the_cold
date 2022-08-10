extends State

class_name Move


const SPEED = 50

var velocity = Vector2.ZERO
var destination = Vector2.ZERO
var next_position = Vector2.ZERO
var path = []

func enter(msg := {}) -> void:
	if not msg.has('destination'):
		print('Error: Missing destination on move state')
		return
	destination = msg.destination
	path = WorldState.pathfinder.find_path(actor.position, destination)
	if len(path) == 0:
		return
	next_position = path[0]


func update(delta):
	var arrived_to_next_point = move_to(next_position, delta)
	if arrived_to_next_point:
		path.remove(0)
		if len(path) == 1:
			state_machine.transition('idle')
			return
		next_position = path[0]
	

func move_to(world_position, delta):
	velocity = (world_position - actor.position).normalized() * SPEED
	actor.position += velocity * delta

	if actor.position.distance_to(world_position) < 2.0:
		actor.position = world_position
	return actor.position.distance_to(world_position) == 0



func exit() -> void:
	pass
