extends Node
var fsm: StateMachine


# Called when the node enters the scene tree for the first time.
func enter():
	fsm.stateLabel.text = "JUMP"
	if Input.is_action_just_pressed("Jump"):
		fsm.character.velocity.y = 20


func exit(state_name):
	fsm.change_to(state_name)

func _unhandled_input(event: InputEvent) -> void:
	var input_dir = Input.get_vector("Left", "Right", "Forward", "Backward")
	var dir = (fsm.character.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if dir:
		fsm.character.velocity.x = dir.x * 20
		fsm.character.velocity.z = dir.z * 20
	else:
		fsm.character.velocity.x = 0
		fsm.character.velocity.z = 0

func _physics_process(delta: float) -> void:
	fsm.character.velocity.y -= 9.8 * delta
	fsm.character.move_and_slide()
	if fsm.character.is_on_floor() and fsm.character.velocity.y == 0:
		exit("Idle")
	if Input.is_action_just_pressed("Sprint"):
		exit("Dash")
