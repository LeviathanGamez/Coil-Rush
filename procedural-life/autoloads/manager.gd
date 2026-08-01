extends Node

signal make_more_joints
var radius : int = 10
var distance : int = 25
var joint_count : int = 30
var modes = ["snake","lizard"]
var mode = modes[1]
var mouse_mode = true


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		print("ye")
		joint_count += 1
		radius += 1
		distance += 1
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
