extends Node2D
@onready var body : Line2D = $body

var anchor := Vector2(30,30)
var radius := Manager.radius
var joint_count := Manager.joint_count
var joints : Array = []
var head_joints : Array
var head : Head
var colors : Array = [Color.RED,Color.ORANGE,Color.YELLOW,Color.GREEN,Color.CYAN,Color.BLUE,Color.PURPLE,Color.DEEP_PINK]


func _ready() -> void:
	head = Head.new(Vector2(0,0),radius)
	make_joints()
	Manager.make_more_joints.connect(make_joints)
	
func make_joints():
	for i in range(joint_count):
		joints.append(Joint.new(Vector2(20*i,20*i),radius-i/2))
	head_joints = joints.duplicate()
	head_joints.pop_back()
	head_joints.push_front(head)

func _process(delta: float) -> void:
	update_head(get_global_mouse_position())
	update_joints(delta)
	
	draw_points()
	
func update_head(mouse_pos : Vector2):
	head.update(mouse_pos)
	
func update_joints(delta):
	for i in range(len(joints)):
		joints[i].update(head_joints[i],delta)
		
func draw_points():
	body.clear_points()
	body.add_point(head.position,0)
	for i in range(len(joints)):
		body.add_point(joints[i].position,i+1)
