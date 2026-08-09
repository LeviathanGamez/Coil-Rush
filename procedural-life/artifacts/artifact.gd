extends Node2D

@export var stats: Artifact_Type
@onready var sprite : Sprite2D = $Sprite2D
@onready var area2d : Area2D = $Area2D
@onready var particle_node : Node = $"../../Particles"
@onready var snake = $"../../snake2"

signal take


var fruit_particles = preload("res://particles/fruit_particles.tscn")

func _ready():
	if stats == null:
		stats = load("res://artifacts/resources/coin.tres")
	var err = area2d.area_entered.connect(taken)

func _process(_delta):
	var snake_body = snake.get_node("body")
	if global_position.distance_to(snake_body.to_global(snake_body.points[0])) > 100:
		sprite.material.set_shader_parameter("outline_color", Color(0.0, 0.131, 0.301, 1.0))
	else:
		sprite.material.set_shader_parameter("outline_color", Color(1, 1, 1, 1))
		 

func taken(area: Area2D):
	if area.get_parent().name == "snake2":
		emit_signal("take",stats.combo_plus)
		var fruit = fruit_particles.instantiate()
		fruit.emitting = true
		fruit.texture = sprite.texture
		fruit.global_position = global_position
		particle_node.add_child(fruit)
		var collider = area.get_parent()
		queue_free()
