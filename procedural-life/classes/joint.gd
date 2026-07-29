class_name Joint

var position : Vector2
var velocity : Vector2
var direction : Vector2
var distance = 100

func _init(pos: Vector2):
	position = pos
	velocity = Vector2(60,60)
	
func update(parent,delta: float):
	position = parent.position + (position-parent.position).normalized() * distance
