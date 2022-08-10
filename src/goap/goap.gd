extends Node

class_name Goap


var action_planner = GoapActionPlanner.new()


func _ready():
	action_planner.actions = get_children()
