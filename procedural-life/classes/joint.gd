class_name Joint

var position : Vector2
var direction : Vector2
var distance = Manager.distance
var radius : float

func _init(pos: Vector2, radi: float):
	position = pos
	radius = radi
	
func update(parent,delta: float):
	direction = (position-parent.position).normalized() 
	position = parent.position + direction * distance

	
func get_sides() -> Array[Vector2]:
	var side_left = position + direction.rotated(-PI/2) * radius
	var side_right = position + direction.rotated(PI/2) * radius
	return [side_left,side_right]
