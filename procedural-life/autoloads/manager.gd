extends Node

signal make_more_joints
var radius : int = 20
var distance : int = 20
var joint_count : int = 50
var modes = ["snake","lizard"]
var mode = modes[1]
var mouse_mode = true


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		update_variables(1,1,1)
	
func update_variables(joint_plus,radius_plus,distance_plus):
	print("vars",joint_count,radius,distance)
	joint_count += joint_plus
	radius += radius_plus
	distance += distance_plus
	print("vars after",joint_count,radius,distance)
	make_more_joints.emit()
		
#func _ready():
#	if mode == "snake":
#		radius = 20
#		distance = 20
#		joint_count = 100
#	elif mode == "lizard":
#		radius = 10
#		distance = 50
#		joint_count = 10
