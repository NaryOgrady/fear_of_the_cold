extends Node

class_name State


onready var actor = get_owner()
onready var state_machine = actor.get_node('StateMachine')

func update(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	pass


func enter(_msg := {}) -> void:
	pass


func exit() -> void:
	pass
