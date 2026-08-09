extends Node

signal make_more_joints
var radius : int = 20
var distance : int = 10
var joint_count : int = 10
var width : int = 10
var speed : float = 3
#var modes = ["snake","lizard"]
#var mode = modes[1]
var mouse_mode = true

var score = 0	
var combo = 1

#func _input(event: InputEvent) -> void:
#	if event.is_action_pressed("click"):
#		update_variables(1,1,1,0.5)

func reset_variables():
	radius = 20
	distance  = 10
	joint_count = 10
	width = 10
	speed = 3
func update_variables(joint_plus,radius_plus,distance_plus,speed_plus):
	joint_count += joint_plus
	distance += distance_plus
	speed += speed_plus
	width += radius_plus
	radius += radius_plus 
	make_more_joints.emit()
		
