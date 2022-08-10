extends StaticBody2D

class_name Firepit


onready var timer = $Timer

export (float) var build_time: float = 0.0
export (float) var fire_duration: float = 0.0


func _ready():
	timer.wait_time = fire_duration
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	WorldState.set_state('is_cold', true)
	queue_free()
