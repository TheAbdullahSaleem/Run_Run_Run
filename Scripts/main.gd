extends Node3D
var obstacle := preload("res://Scenes/Obstacles.tscn")
var ground := preload("res://Scenes/Ground.tscn")
@export var Player : CharacterBody3D
@export var pause : Control
@export var gameover : Control

var n = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(4):
		spawn_obstacles()
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
	var obstacle_area = obstacle_instance.get_node("Area3D")
	obstacle_area.body_entered.connect(_on_obstacle_body_entered)
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
	


func _on_obstacle_body_entered(body: Node3D):
	if body is CharacterBody3D:
		print("A character body entered!")
		gameover.visible = true
		get_tree().paused = true
	else:
		return 
