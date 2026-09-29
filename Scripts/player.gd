extends CharacterBody3D

const forward_velocity = 10
const SPEED = 5.0
const JUMP_VELOCITY = 4.5


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Get the input direction and handle the movement/deceleration.
	velocity.z = -forward_velocity
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_x := Input.get_axis("left", "right")
	if input_x:
		velocity.x = input_x * SPEED
		
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()sfb
