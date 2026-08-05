extends Node2D

@export var stats : FruitType
@onready var sprite : Sprite2D = $Sprite2D
@onready var area2d : Area2D = $Area2D
@onready var particle_node : Node = $"../../Particles"
@onready var snake = $"../../snake2"

var fruit_particles = preload("res://particles/fruit_particles.tscn")

func _ready():
	if stats == null:
		stats = load("res://entities/fruit/resource/cactus_fruit.tres")
	var err = area2d.area_entered.connect(eaten)

func _process(_delta):
	var snake_body = snake.get_node("body")
	if global_position.distance_to(snake_body.to_global(snake_body.points[0])) > 100:
		sprite.material.set_shader_parameter("outline_color", Color(0.0, 0.131, 0.301, 1.0))
	else:
		sprite.material.set_shader_parameter("outline_color", Color(1, 1, 1, 1))
		 

func eaten(area: Area2D):
	if area.get_parent().name == "snake2":
		var fruit = fruit_particles.instantiate()
		fruit.emitting = true
		fruit.texture = sprite.texture
		fruit.global_position = global_position
		particle_node.add_child(fruit)
		var collider = area.get_parent()
		Manager.update_variables(stats.length_plus,stats.radius_plus,stats.distance_plus,stats.speed_plus)
		queue_free()
