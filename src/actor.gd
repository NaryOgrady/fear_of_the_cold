extends KinematicBody2D

class_name Actor


export (int) var cold_resistance: int = 0

onready var state_machine = $StateMachine
onready var hungerTimer = $HungerTimer

func _ready() -> void:
	var agent = GoapAgent.new(self, [
		KeepWarmGoal.new(self),
		KeepFedGoal.new(self),
		RelaxGoal.new()
	])
	add_child(agent)
	WorldState.set_state('is_hungry', true)
	hungerTimer.start()
	



func get_thermal_sensation() -> int:
	return int(abs(WorldState.get_state('temperature') - cold_resistance) * 
		(WorldState.get_state('temperature') / WorldState.get_state('temperature')))


func _on_HungerTimer_timeout():
	WorldState.set_state('is_hungry', true)
