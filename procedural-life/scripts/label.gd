extends Label

@onready var fruit = $"../../Fruits/orange"
@onready var combo_timer : Timer = $"../ComboRect/Combotimer"
@onready var coolness_timer : Timer = $"../CoolRect/CoolnessTimer"
@onready var snake = $"../../snake2"
@onready var combo_label = $"../ComboRect/Combo"
@onready var cool_label= $"../CoolRect/Coolness"

@onready var combo_rect : ColorRect = $"../ComboRect"
@onready var combo_rect2 : ColorRect = $"../ComboRect2"

@onready var cool_rect : ColorRect = $"../CoolRect"
@onready var cool_rect2 : ColorRect = $"../CoolRect2"
@onready var fruit_node : Node = $"../../Fruits"
@onready var artifact_node : Node = $"../../Artifacts"

@onready var taken_sfx : AudioStreamPlayer2D = $Taken
@onready var eaten_sfx : AudioStreamPlayer2D = $Eaten

@onready var death_label : Label = $"../../Death_menu/Resume3"

var tween : Tween
	
var artifact_worth : int = 1000

func _ready():
	pivot_offset = size / 2
func _process(_delta):
	for fruit in fruit_node.get_children():
		if not fruit.eat.is_connected(change_score):
			fruit.eat.connect(change_score)
	for artifact in artifact_node.get_children():
		if not artifact.take.is_connected(change_combo):
			artifact.take.connect(change_combo)
		
	text = "Score: " + str(int(Manager.score))
	death_label.text = "Final Score: " + str(int(Manager.score))
	combo_label.text = "Combo: X" + str(round(Manager.combo*10)/10)
	combo_rect.size.x = combo_label.size.x + 28
	combo_rect2.size.x = combo_rect.size.x * (combo_timer.time_left/ combo_timer.wait_time)
	cool_rect.size.x = cool_label.size.x 
	cool_rect2.size.x = cool_rect.size.x * (coolness_timer.time_left/coolness_timer.wait_time)

func change_score(value):
	Manager.score += value * Manager.combo
	coolness_timer.start()
	expand()
	eaten_sfx.pitch_scale = randf_range(0.9, 1.1)
	eaten_sfx.play()


	
func change_combo(value):
	Manager.combo += value
	Manager.score += artifact_worth * Manager.combo
	combo_timer.start()
	expand()
	taken_sfx.pitch_scale = randf_range(0.9, 1.1)
	taken_sfx.play()
	
func expand():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self, "scale", Vector2(1.5,1.5), 0.1)
	tween.parallel().tween_property(self, "modulate", Color(1,0,0,1), 0.1)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", Vector2.ONE, 2).set_delay(0.1)
	tween.parallel().tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 1.0), 2)
	
	
func _on_combotimer_timeout() -> void:
	Manager.combo = 1


func _on_coolness_timer_timeout() -> void:
	snake.kill("timeout")
