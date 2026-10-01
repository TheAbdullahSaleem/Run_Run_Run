extends CharacterBody3D
@export var anim_player : AnimationPlayer
const forward_velocity = 5
const SPEED = 5.0
const JUMP_VELOCITY = 7.5


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if is_on_floor():
		if velocity.z != 0:
			anim_player.play("running/mixamo_com") 
		else:
			anim_player.play("idle/mixamo_com") 

	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim_player.play("jump/mixamo_com")
	velocity.z = -forward_velocity
	var input_x := Input.get_axis("left", "right")
	if input_x != 0:
		velocity.x = input_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
