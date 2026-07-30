extends Node2D

var anchor := Vector2(30,30)
var radius := Manager.radius
var joint_count := Manager.joint_count
var joints : Array = []
var head_joints : Array
var head : Head

func _ready() -> void:
	head = Head.new(Vector2(0,0),radius)
	for i in range(joint_count):
		joints.append(Joint.new(Vector2(20*i,20*i),radius-i/2))
	head_joints = joints.duplicate()
	head_joints.pop_back()
	head_joints.push_front(head)


func _process(delta: float) -> void:
	update_head(get_global_mouse_position())
	update_joints(delta)
	queue_redraw()
	
func update_head(mouse_pos : Vector2):
	head.update(mouse_pos)
	
func update_joints(delta):
	for i in range(len(joints)):
		joints[i].update(head_joints[i],delta)
	
func _draw():
	var white : Color = Color.WHITE
	var brown : Color = Color.BROWN
	var colors : Array = [Color.RED,Color.ORANGE,Color.YELLOW,Color.GREEN,Color.CYAN,Color.BLUE,Color.PURPLE,Color.DEEP_PINK]
	draw_circle(head.position,head.radius,white)
	for i in range(len(joints)):
		draw_circle(joints[i].position,joints[i].radius,colors[wrap(i,0,len(colors))])
		draw_line(head_joints[i].position,joints[i].position,colors[wrap(i,0,len(colors))],head_joints[i].radius)
	
	for i in range(len(joints)):
		draw_line(head_joints[i].get_sides()[0],joints[i].get_sides()[0],colors[wrap(i,0,len(colors))],head_joints[i].radius)
		draw_line(head_joints[i].get_sides()[1],joints[i].get_sides()[1],colors[wrap(i,0,len(colors))],head_joints[i].radius)
