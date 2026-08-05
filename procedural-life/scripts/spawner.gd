extends Node

var cactus_scene = preload("res://fruits/cactus_fruit.tscn")
var orange = preload("res://fruits/orange.tscn")
var prickly_pear = preload("res://fruits/prickly_pear.tscn")
var fruits = [cactus_scene,orange,prickly_pear]
@onready var fruit_node = $"../Fruits"
@onready var snake = $"../snake2"
@onready var spawn_timer : Timer = $Timer
var can_trigger = true

var fruit
var old_fruit

func _process(_delta):
	if get_tree().get_nodes_in_group("Fruits").size() < 3 and can_trigger:
		old_fruit = fruit
		can_trigger = false
		await get_tree().create_timer(1).timeout
		var position = Vector2(randi_range(-576,576),randi_range(-324,324))
		var snake_body = snake.get_node("body")
		while position.distance_to(snake_body.to_global(snake_body.points[0])) < 300:
			position = Vector2(randi_range(-576,576),randi_range(-324,324))
		while fruit == old_fruit:
			fruit = fruits.pick_random().instantiate()
		old_fruit = fruit
		fruit.global_position = position
		fruit_node.add_child(fruit)
		can_trigger = true
