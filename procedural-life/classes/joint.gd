class_name Joint

var position : Vector2
var direction : Vector2
var distance = Manager.distance
var radius : float
var index : int
var global_index = 1

func _init(pos: Vector2, radi: float):
	position = pos
	radius = radi
	index = global_index
	global_index += 1
	
func update(parent,delta: float):
	direction = (position-parent.position).normalized() 
	var normal = Vector2(-direction.y,direction.x)
	
	var t = Time.get_ticks_msec()/1000
	var wave = sin(t * 1000 + index * 0.4) * 0.1
	direction = direction.rotated(wave)
	position = parent.position + direction * distance
	
	#var pre_position =  parent.position + direction * distance
	#position = pre_position + normal * wave

	
func get_sides() -> Array[Vector2]:
	var side_left = position + direction.rotated(-PI/2) * radius
	var side_right = position + direction.rotated(PI/2) * radius
	return [side_left,side_right]
