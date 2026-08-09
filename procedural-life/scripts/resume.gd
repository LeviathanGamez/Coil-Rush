extends Button

@onready var pause_menu : Control = $".."

func _on_pressed() -> void:
	pause_menu.visible = false
	get_tree().paused = false
