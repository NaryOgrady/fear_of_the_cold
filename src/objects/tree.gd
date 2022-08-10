extends StaticBody2D

class_name TreeObject


signal chopped

onready var timer = $Timer


export (int) var resources: int = 0
export (float) var chopping_time = 0.0


func _ready() -> void:
	timer.wait_time = chopping_time


func chop():
	timer.start()
	yield(timer, 'timeout')

	queue_free()
	emit_signal('chopped')
