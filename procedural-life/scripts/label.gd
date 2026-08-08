extends Label

@onready var fruit = $"../../Fruits/orange"
@onready var combo_timer : Timer = $"../ComboRect/Combotimer"
@onready var coolness_timer : Timer = $"../CoolRect/CoolnessTimer"
@onready var snake = $"../../snake2"
@onready var combo_label = $"../ComboRect/Combo"

@onready var combo_rect : ColorRect = $"../ComboRect"
@onready var combo_rect2 : ColorRect = $"../ComboRect2"

@onready var cool_rect : ColorRect = $"../CoolRect"
@onready var cool_rect2 : ColorRect = $"../CoolRect2"

func _process(_delta):
	for fruit in $"../../Fruits".get_children():
		fruit.eat.connect(change_score)
	text = "Score: " + str(int(Manager.score))
	combo_label.text = "Combo: X" + str(Manager.combo)
	combo_rect.size.x = combo_label.size.x + 28
	combo_rect2.size.x = combo_rect.size.x * (combo_timer.time_left/ combo_timer.wait_time)
	cool_rect2.size.x = cool_rect.size.x * (coolness_timer.time_left/coolness_timer.wait_time)
func change_score(value):
	Manager.score += value * Manager.combo
	coolness_timer.start()
	change_combo()
	
func change_combo():
	Manager.combo += 0.2
	combo_timer.start()

func _on_combotimer_timeout() -> void:
	Manager.combo = 1


func _on_coolness_timer_timeout() -> void:
	snake.kill()
