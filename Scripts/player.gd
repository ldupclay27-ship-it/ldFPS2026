extends CharacterBody3D
# move camera around with mouse
# move player with key board
# cont=strain mouse
# jump
# capture the mouse
@export var gravity:float = 10
@export var max_jumps:int = 2
var jumps: int = 0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.screen_relative.x * 0.5
		# rotate up and down
		%Camera3D.rotation_degrees.x -= event.screen_relative.y * 0.2
		%Camera3D.rotation_degrees.x = clamp(%Camera3D.rotation_degrees.x, -80.0, 80.0)
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("fullscreen"):
		var fs = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
		if fs:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _physics_process(delta: float) -> void:
	const SPEED = 5.5
	var input_direction_2D = Input.get_vector("move_left","move_right","move_forward","move_back")
	
	var input_direction_3D = Vector3(input_direction_2D.x, 0, input_direction_2D.y)
	
	var direction = transform.basis * input_direction_3D
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	
	velocity.y -= gravity * delta
	if Input.is_action_just_pressed("jump") and jumps <= max_jumps:
		velocity.y = 10.0
		jumps += 1
		
	elif Input.is_action_just_released("jump") and velocity.y > 0.0:
		velocity.y = 0.0
	if is_on_floor():
		jumps = 0
	move_and_slide()
