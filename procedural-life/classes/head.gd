class_name Head

var position : Vector2
var direction : Vector2
var mouse_lerp : float = 0.2
var radius := Manager.radius

func _init(pos: Vector2):
	position = pos
	
func update(mouse_pos : Vector2):
	direction = (mouse_pos - position).normalized()
	position = lerp(position,mouse_pos,mouse_lerp)
	
func get_sides() -> Array[Vector2]:
	
	var side_left = position + direction.rotated(PI/2) * radius
	var side_right = position + direction.rotated(-PI/2) * radius
	return [side_left,side_right]
