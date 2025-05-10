extends CharacterBody2D

const JUMP_VELOCITY = -1000.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * 2

	# Handle jump.
	if $"..".is_correct and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$"..".is_correct = false

	move_and_slide()
