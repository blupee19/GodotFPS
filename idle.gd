extends Node

var fsm: StateMachine

func enter():
	fsm.stateLabel.text = "IDLE"

func exit(next_state):
	fsm.change_to(next_state)

func _unhandled_input(event: InputEvent) -> void:
	if Input.get_vector("Left","Right","Backward","Forward"):
		exit("Run")
	if Input.is_action_just_pressed("Jump") and fsm.character.is_on_floor():
		exit("Jump")
	if Input.is_action_just_pressed("Sprint"):
		exit("Dash")

func _physics_process(delta: float) -> void:
	fsm.character.velocity.x = 0
	fsm.character.velocity.z = 0
	fsm.character.velocity.y -= 9.8 * delta
	fsm.character.move_and_slide()
