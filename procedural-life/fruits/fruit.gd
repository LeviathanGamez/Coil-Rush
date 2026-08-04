extends Node2D

@export var stats : FruitType
@onready var sprite : Sprite2D = $Sprite2D
@onready var area2d : Area2D = $Area2D
@onready var particle_node : Node = $"../Particles"

var fruit_particles = preload("res://particles/fruit_particles.tscn")

func _ready():
	if stats == null:
		stats = load("res://entities/fruit/resource/cactus_fruit.tres")
	var err = area2d.area_entered.connect(eaten)



func eaten(area: Area2D):
	var fruit = fruit_particles.instantiate()
	fruit.emitting = true
	fruit.texture = sprite.texture
	fruit.global_position = global_position
	particle_node.add_child(fruit)
	var collider = area.get_parent()
	Manager.update_variables(stats.length_plus,stats.radius_plus,stats.distance_plus,stats.speed_plus)
	queue_free()
