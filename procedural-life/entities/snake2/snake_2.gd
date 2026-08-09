extends Node2D
@onready var body : Line2D = $body
@onready var eye1 : Sprite2D = $eye1
@onready var eye2 : Sprite2D = $eye2
@onready var eye_ball1 : Sprite2D = $eye_ball1
@onready var eye_ball2 : Sprite2D = $eye_ball2
@onready var collision : CollisionShape2D = $Area2D/CollisionShape2D
@onready var outline : Line2D = $Outline
@onready var circle_collision : CollisionShape2D = $Area2D/CollisionShape2D
@onready var death_menu = $"../Death_menu"

var outline_width = 6

var anchor := Vector2(30,30)
var radius := Manager.radius
var joint_count := Manager.joint_count
var joints : Array = []
var head_joints : Array
var head : Head
var colors : Array = [Color.RED,Color.ORANGE,Color.YELLOW,Color.GREEN,Color.CYAN,Color.BLUE,Color.PURPLE,Color.DEEP_PINK]
var eyeball_movement = 0.007

var color1
var color2 
var color3

func _ready() -> void:
	head = Head.new(Vector2(0,0),radius)
	head.death.connect(kill.bind("exited boundry of map"))
	make_joints()
	Manager.make_more_joints.connect(make_joints)
	collision.shape.radius = int(radius)
	color1 = body.material.get_shader_parameter("Color1")
	color2 = body.material.get_shader_parameter("Color2")
	color3 = body.material.get_shader_parameter("Color3")
	
	
func make_joints():
	radius  =  Manager.radius
	(circle_collision.shape as CircleShape2D).radius = Manager.radius -10
	body.width = Manager.width
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
	outline.width = body.width + outline_width
	outline.points = body.points
	
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
	var problem 
	var a
	var b
	for joint in joints:
		if joint == head:
			continue
		a = joint.position.distance_squared_to(head.position)+5
		b = Manager.distance * Manager.distance
		if a < b:
			collision = true
			problem = joint
			break
	
	if collision:
		Manager.combo = 1
		
	
		body.material.set_shader_parameter("Color1", Color("#fb1818"))
		body.material.set_shader_parameter("Color2", Color("#fb1818"))
		body.material.set_shader_parameter("Color3", Color("#fb1818"))
		await get_tree().create_timer(0.2).timeout
		body.material.set_shader_parameter("Color1", color1)
		body.material.set_shader_parameter("Color2", color2)
		body.material.set_shader_parameter("Color3", color3)
		collision = false
		
func kill(text):
	
	death_menu.visible = true 
	get_tree().paused = true
	print("SNAKE HAS DIED")
	print("Cause of death: " + text)
	#queue_free()
