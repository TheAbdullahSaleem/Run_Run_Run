extends Node3D
var obstacle := preload("res://Scenes/Obstacles.tscn")
var ground := preload("res://Scenes/Ground.tscn")
var lives := 3
@export var Player : CharacterBody3D
@export var pause : Control
var lives_label = preload("res://Scenes/lives.tscn")
@onready var label_instance = lives_label.instantiate()
var n = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	for i in range(3):
		spawn_obstacles()
	add_child(label_instance)
	#spawning_obstacles()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	deleting_obstacles()
	deleting_ground()
	pausing()
	
func spawn_obstacles():
	var obstacle_instance := obstacle.instantiate()
	add_child(obstacle_instance)
	obstacle_instance.global_position.x = randi_range(-4,4)
	obstacle_instance.global_position.y = 1.573
	obstacle_instance.global_position.z = Player.global_position.z + randi_range(-40,-20)

func deleting_obstacles():
	for child in get_children():
		if child.is_in_group("obstacles"):
			if child.global_position.z > (Player.global_position.z+5):
				spawn_obstacles()
				child.queue_free()
func spawn_ground():
	var ground_instance := ground.instantiate()
	add_child(ground_instance)
	ground_instance.global_position.x = 0
	ground_instance.global_position.y = 0
	ground_instance.global_position.z = Player.global_position.z - 5
func deleting_ground():
	for child in get_children():
		if child.is_in_group("Ground"):
			if child.global_position.z > (Player.global_position.z+5):
				spawn_ground()
				child.queue_free()
func pausing():
	if Input.is_action_pressed("pause"):
		pause.visible = true
		get_tree().paused = true
	
func loose_life():
	lives -= 1
	label_instance.text = "Lives : " + str(lives)
