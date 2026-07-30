class_name Head

var position : Vector2
var direction : Vector2
var mouse_lerp : float = 0.1
var distance : float = 10
var radius : float 
#for big circle movement
var count := 0
var big_radius := 350

func _init(pos: Vector2, radi: float):
	position = pos
	radius = radi
	
func update(mouse_pos : Vector2):
	count += 2
	#var old_direction = direction
	mouse_pos = Vector2(cos(deg_to_rad(count))*big_radius,sin(deg_to_rad(count))*big_radius)
	direction = (mouse_pos - position).normalized()
	#var angle_diff = direction.angle_to(old_direction)
	#if abs(angle_diff) > PI/8:
	#	direction = old_direction.rotated(sign(angle_diff) * PI / 8)
	var target_position = mouse_pos - direction * distance
	position += (target_position-position) * mouse_lerp
	
func get_sides() -> Array[Vector2]:
	
	var side_left = position + direction.rotated(PI/2) * radius
	var side_right = position + direction.rotated(-PI/2) * radius
	return [side_left,side_right]
