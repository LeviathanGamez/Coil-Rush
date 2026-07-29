class_name Head

var position : Vector2
var velocity : Vector2
var direction : Vector2
var mouse_lerp : float = 0.01

func _init(pos: Vector2):
	position = pos
	velocity = Vector2(0,0)
	
func update(mouse_pos : Vector2):
	position = lerp(position,mouse_pos,mouse_lerp)
