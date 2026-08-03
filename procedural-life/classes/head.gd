class_name Head

var position : Vector2
var direction : Vector2
var mouse_lerp : float = 0.05
var distance : float = 30
var radius : float 
# 3 is ez, 5 normal, 7 fast
var speed : float = 60 * 7
#for big circle movement
var count := 0
var big_radius := 350
var eye_closeness := 1.5

var new_direction
var last_mouse_pos : Vector2

func _init(pos: Vector2, radi: float):
	position = pos
	radius = radi
	Manager.make_more_joints.connect(update_vairables)

func update_vairables():
	speed = Manager.speed
	
func update(mouse_pos : Vector2, delta):
	count += 2
	#var old_direction = direction
	if not Manager.mouse_mode:
		mouse_lerp = 0.05
		mouse_pos = Vector2(cos(deg_to_rad(count))*big_radius,sin(deg_to_rad(count))*big_radius)
	
	if mouse_pos != last_mouse_pos:
		new_direction = (mouse_pos - position).normalized()
		last_mouse_pos = mouse_pos
	
	#var angle_diff = direction.angle_to(old_direction)
	#if abs(angle_diff) > PI/8:
	#	direction = old_direction.rotated(sign(angle_diff) * PI / 8)
	direction = direction.lerp(new_direction,0.1).normalized()
	#var target_position = mouse_pos - direction * distance
	#position += (target_position-position) * mouse_lerp
	position += direction * speed * delta
	if position.x > 576 or position.x < -576:
		kill()
	if position.y > 324 or position.y < -324:
		kill()
		
func kill():
	print("im dead")
	
func get_sides() -> Array[Vector2]:
	
	var side_left = position + direction.rotated(PI/2) * radius
	var side_right = position + direction.rotated(-PI/2) * radius
	return [side_left,side_right]
	
func get_eyes() -> Array[Vector2]:
	
	var side_left = position + direction.rotated(PI/4) * radius / eye_closeness
	var side_right = position + direction.rotated(-PI/4) * radius / eye_closeness
	return [side_left,side_right]
