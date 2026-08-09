extends Button

@onready var tutorial = $"../../Tutorial"
func _on_pressed() -> void:
	tutorial.visible = true
