extends Node2D

var anchor := Vector2(30,30)
var radius := 5
var joint_count : int = 8
var joints : Array = []
var head_joints : Array
var head : Head

func _ready() -> void:
	head = Head.new(Vector2(0,0))
	for i in range(joint_count):
		joints.append(Joint.new(Vector2(20*i,20*i)))
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
	var colors : Array = [Color.RED,Color.ORANGE,Color.YELLOW,Color.GREEN,Color.CYAN,Color.BLUE,Color.PURPLE,Color.PINK]
	draw_circle(head.position,radius,white)
	for i in range(len(joints)):
		draw_circle(joints[i].position,radius,colors[i])
		draw_line(head_joints[i].position,joints[i].position,colors[i],1)
