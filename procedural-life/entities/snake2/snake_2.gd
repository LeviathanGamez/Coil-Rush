extends Node2D
@onready var body : Line2D = $body
@onready var eye1 : Sprite2D = $eye1
@onready var eye2 : Sprite2D = $eye2
@onready var eye_ball1 : Sprite2D = $eye_ball1
@onready var eye_ball2 : Sprite2D = $eye_ball2
@onready var collision : CollisionShape2D = $Area2D/CollisionShape2D

var anchor := Vector2(30,30)
var radius := Manager.radius
var joint_count := Manager.joint_count
var joints : Array = []
var head_joints : Array
var head : Head
var colors : Array = [Color.RED,Color.ORANGE,Color.YELLOW,Color.GREEN,Color.CYAN,Color.BLUE,Color.PURPLE,Color.DEEP_PINK]
var eyeball_movement = 0.007

func _ready() -> void:
	head = Head.new(Vector2(0,0),radius)
	make_joints()
	Manager.make_more_joints.connect(make_joints)
	collision.shape.radius = int(radius)
	
	
func make_joints():
	radius  =  Manager.radius
	joint_count = Manager.joint_count
	var temp_joints = joints.duplicate()
	joints = []
	if temp_joints.size() == 0:
		for i in range(joint_count):
			joints.append(Joint.new(Vector2(20*i,20*i),radius-i/2))
	else:
		for i in range(joint_count):
			if i >= temp_joints.size():
				joints.append(Joint.new(temp_joints[i-1].position+Vector2(10,10),radius-i/2))
			else:
				joints.append(Joint.new(temp_joints[i].position,radius-i/2))
			
	head_joints = joints.duplicate()
	head_joints.pop_back()
	head_joints.push_front(head)

func _process(delta: float) -> void:
	update_head(get_global_mouse_position(),delta)
	update_joints(delta)
	collision_check()
	draw_points()
	
func update_head(mouse_pos : Vector2,delta: float):
	head.update(mouse_pos,delta)
	collision.global_position = head.position
	
func update_joints(delta):
	for i in range(len(joints)):
		joints[i].update(head_joints[i],delta)
		
func draw_points():
	body.clear_points()
	body.add_point(head.position,0)
	for i in range(len(joints)):
		body.add_point(joints[i].position,i+1)
	var mouse_pos = get_global_mouse_position()
	var eye1_pos = head.get_eyes()[0]
	var eye2_pos = head.get_eyes()[1]
	eye1.global_position = eye1_pos 
	eye2.global_position = eye2_pos 
	eye_ball1.global_position = eye1_pos + (mouse_pos-eye1_pos)* eyeball_movement
	eye_ball2.global_position = eye2_pos + (mouse_pos-eye2_pos)* eyeball_movement

func collision_check():
	var collision
	for joint in joints:
		if joint.position.distance_squared_to(head.position) < radius * radius+5:
			collision = true
	
	#if collision:
#		queue_free()
