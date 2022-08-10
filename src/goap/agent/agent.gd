extends Node

class_name GoapAgent


var _actor
var _goals
var _current_goal
var _current_plan
var _current_plan_step = 0

onready var goap = get_tree().current_scene.get_node('Goap')

func _init(actor, goals: Array):
	_actor = actor
	_goals = goals


func _process(delta: float) -> void:
	var goal = _get_best_goal()
	if _current_goal == null or goal != _current_goal:
		var blackboard = {
			'position': _actor.position
		}

		for s in WorldState._state:
			blackboard[s] = WorldState._state[s]

		_current_goal = goal
		_current_plan = goap.action_planner.get_plan(_current_goal, blackboard)
		_current_plan_step = 0
		return

	_follow_plan(_current_plan, delta)


func _follow_plan(plan, delta):
	if plan.size() == 0 or _current_plan_step > plan.size() - 1:
		return

	var current_step = plan[_current_plan_step]

	if current_step.in_progress:
		return

	current_step.perform(_actor, delta)
	yield(current_step, 'finished')

	_current_plan_step += 1


func _get_best_goal() -> GoapGoal:
	var highest_priority
	for goal in _goals:
		if not goal.is_valid():
			continue
		if highest_priority == null or goal.priority() > highest_priority.priority():
			highest_priority = goal
	
	return highest_priority
