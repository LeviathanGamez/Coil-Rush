extends Button



func _on_pressed() -> void:
	get_tree().reload_current_scene()
	Manager.reset_variables()
