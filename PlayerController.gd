extends CharacterBody3D

const SPEED = 20.0
const JUMP_VELOCITY = 6.0
const SENSITIVITY = 0.05
const dashSpeed = 50
var isDashing = false
var canDash = true 
var slide = true
@onready var fwd_dir = self.global_transform.basis.z
@onready var camera = $Head/Camera3D
@onready var head = $Head

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _process(_delta):
	pass
	#$Control/Label.text = str(basis.z)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= 9.8 * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("Sprint") and canDash:
		isDashing = true
		canDash = false
		$dashTimer.start()
		$canDash.start()
		velocity = fwd_dir * dashSpeed

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("Left", "Right", "Forward", "Backward")
	var direction = (self.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
			if isDashing:
				velocity.x = direction.x * dashSpeed
				velocity.z = direction.z * dashSpeed
			else:
				velocity.x = direction.x * SPEED
				velocity.z = direction.z * SPEED
	else:
		velocity.x = 0.0
		velocity.z = 0.0

	move_and_slide()
	
	## FOV Change ##
	if Input.is_action_just_pressed("Sprint") and (Input.is_action_pressed("Forward") or Input.is_action_pressed("Backward")):
		var tween = create_tween()
		tween.tween_property(camera, "fov", 100, 0.08)
	if Input.is_action_just_released("Sprint") or (Input.is_action_just_released("Forward") or Input.is_action_just_released("Backward")):
		var tween = create_tween()
		tween.tween_property(camera, "fov", 90, 0.08)
	if !canDash and !isDashing:
		var tween = create_tween()
		tween.tween_property(camera, "fov", 90, 0.05)
	## FOV Change ##

func _input(event):
	if Input.is_action_just_pressed("Escape"):
		get_tree().quit()
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		#camera.basis(rotate)
		camera.rotate_x(deg_to_rad(event.relative.y * SENSITIVITY * -1 ))
		self.rotate_y(deg_to_rad(event.relative.x * SENSITIVITY * -1))
		var camera_rot = head.rotation_degrees
		camera_rot.x = clamp(camera_rot.x, -70, 70)
		head.rotation_degrees = camera_rot

func _on_timer_timeout() -> void:
	isDashing = false

func _on_can_dash_timeout() -> void:
	canDash = true

func _on_inertia_timeout():
	slide = false
