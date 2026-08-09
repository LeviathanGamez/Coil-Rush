extends Node

@onready var timer : Timer = $Timer

@onready var combo_timer : Timer = $"../UI/ComboRect/Combotimer"
@onready var coolness_timer : Timer = $"../UI/CoolRect/CoolnessTimer"
@onready var color_rect : ColorRect = $ColorRect
@onready var audio_player : AudioStreamPlayer2D = $AudioStreamPlayer2D

var times = 0
var max_times = 5
var difficulty_timer = 30
var tween

func _ready():
	timer.wait_time = difficulty_timer
	timer.start()
	color_rect.color.a = 0
	color_rect.visible = true
	
func _on_timer_timeout() -> void:
	timer.wait_time += 15
	timer.start()
	times += 1
	decrease_time()
	if times >= max_times:
		timer.stop()
		
func decrease_time():
	combo_timer.wait_time -= 1
	coolness_timer.wait_time -= 1
	if tween:
		tween.kill()
	audio_player.play()
	tween = create_tween()
	tween.tween_property(color_rect,"color:a",0.6,0.2)
	tween.tween_property(color_rect,"color:a",0.0,0.15).set_delay(0.2)
	
