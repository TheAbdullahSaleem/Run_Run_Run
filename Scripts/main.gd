extends Node3D
var obstacle := preload("res://Scenes/Obstacles.tscn")
@export var Player : CharacterBody3D
var n = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawning_obstacles()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func spawn_obstacles():
	var obstacle_instance := obstacle.instantiate()
	add_child(obstacle_instance)
	obstacle_instance.global_position.x = randi_range(-4,4)
	obstacle_instance.global_position.y = 0.725
	obstacle_instance.global_position.z = Player.global_position.z + randi_range(-40,-20)

func spawning_obstacles():
	while n<10:
		n += 1
		await get_tree().create_timer(1.0).timeout
		spawn_obstacles()
