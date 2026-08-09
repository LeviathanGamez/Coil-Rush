extends Node

var cactus = preload("res://fruits/scenes/cactus_fruit.tscn")
var orange = preload("res://fruits/scenes/orange.tscn")
var prickly_pear = preload("res://fruits/scenes/prickly_pear.tscn")
var fruits = [cactus,orange,prickly_pear]

var coin = preload("res://artifacts/scenes/coin.tscn")
var diamond = preload("res://artifacts/scenes/diamond.tscn")
var golden_scarab = preload("res://artifacts/scenes/golden_scarab.tscn")
var artifacts = [coin,coin,coin,diamond,diamond,golden_scarab]
@onready var fruit_node = $"../Fruits"
@onready var artifact_node = $"../Artifacts"
@onready var snake = $"../snake2"
@onready var spawn_timer : Timer = $Timer
@onready var pause_menu = $"../PauseMenu"
var can_trigger = true
var can_trigger2 = true

var fruit
var old_fruit
var artifact
var old_artifact

var x_bound = 730
var y_bound = 370

var activated = true
func _ready():
	get_tree().paused = false
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		pause_menu.visible = activated 
		get_tree().paused = activated

func _process(_delta):
	if get_tree().get_nodes_in_group("Fruits").size() < 3 and can_trigger:
		old_fruit = fruit
		can_trigger = false
		await get_tree().create_timer(1).timeout
		var position = Vector2(randi_range(-x_bound,x_bound),randi_range(-y_bound,y_bound))
		var snake_body = snake.get_node("body")
		while position.distance_to(snake_body.to_global(snake_body.points[0])) < 300:
			position = Vector2(randi_range(-576,576),randi_range(-324,324))
		while fruit == old_fruit:
			fruit = fruits.pick_random().instantiate()
		old_fruit = fruit
		fruit.global_position = position
		fruit_node.add_child(fruit)
		can_trigger = true
		
	if get_tree().get_nodes_in_group("Artifacts").size() < 2 and can_trigger2:
		can_trigger2 = false
		old_artifact = artifact
		await get_tree().create_timer(1).timeout
		var position = Vector2(randi_range(-x_bound,x_bound),randi_range(-y_bound,y_bound))
		var snake_body = snake.get_node("body")
		while position.distance_to(snake_body.to_global(snake_body.points[0])) < 300:
			position = Vector2(randi_range(-576,576),randi_range(-324,324))
		while artifact == old_artifact:
			artifact = artifacts.pick_random().instantiate()
		old_artifact = artifact
		artifact.global_position = position
		artifact_node.add_child(artifact)
		can_trigger2 = true
		
