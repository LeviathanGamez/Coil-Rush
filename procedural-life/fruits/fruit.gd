extends Node2D

@export var stats : FruitType
@onready var sprite : Sprite2D = $Sprite2D
@onready var area2d : Area2D = $Area2D

func _ready():
	if stats == null:
		stats = load("res://entities/fruit/resource/cactus_fruit.tres")
	var err = area2d.area_entered.connect(effect)
	print("err", err)
	
func effect(_area: Area2D):
	print("ye")
	queue_free()
