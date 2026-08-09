extends Button

@onready var tutorial = $"../.."
func _on_pressed() -> void:
	tutorial.visible = false
