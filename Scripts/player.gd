extends CharacterBody3D
# move camera around with mouse
# move player with key board
# cont=strain mouse
# jump
# capture the mouse

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.screen_relative.x * 0.5
		# rotate up and down
		%Camera3D.rotation_degrees.x -= event.screen_relative.y * 0.2
		%Camera3D.rotation_degrees.x = clamp(%Camera3D.rotation_degrees.x, -80.0, 80.0)

func _physics_process(delta: float) -> void:
	const SPEED = 5.5
	var input_direction_2D = Input.get_vector("move_left","move_right","move_forward","move_back")
	
	var input_direction_3D = Vector3(input_direction_2D.x, 0, input_direction_2D.y)
	
	var direction = transform.basis * input_direction_3D
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	
	move_and_slide()
